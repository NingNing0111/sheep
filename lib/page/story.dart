import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheep/config/theme/theme.dart';
import 'package:sheep/controller/story.dart';
import 'package:sheep/main.dart';
import 'package:sheep/service/assets_service.dart';

import '../controller/setting.dart';
import '../service/iflytek_service.dart';
import '../service/story_service.dart';

class StoryPage extends GetView<StoryPageController> {
  final _storyController = Get.find<StoryPageController>();
  final audioPlayer = AudioPlayer();
  final _settingController = Get.find<SettingPageController>();

  late final XfService _xfService = XfService(
      appId: _settingController.xfAppID.value,
      apiSecret: _settingController.xfApiSecret.value,
      apiKey: _settingController.xfApiKey.value);
  List<int> _currByte = [];
  int count = 0;
  final isLoadingVideo = false.obs;
  final isPlayingVideo = false.obs;

  StoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _storyController.isTypeDataRead.value
          ? ListView(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: BorderDirectional(
                          bottom:
                              BorderSide(color: AppTheme.light.primaryColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "故事分类",
                        style: TextStyle(fontSize: 16),
                      ),
                      DropdownButton<StoryType>(
                        value: _storyController.currType.value,
                        items: _storyController.storyTypesList
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e.name,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ))
                            .toList(),
                        onChanged: (StoryType? type) async {
                          _storyController.isStoryDataRead.value = false;
                          _storyController.updateCurrType(type!);
                        },
                      ),
                    ],
                  ),
                ),
                _storyController.isStoryDataRead.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _storyController.storyList
                            .map((e) => InkWell(
                                  onTap: () async {
                                    await handleStory(e);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e.title,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              e.type,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "阅读时间：${e.readTime}",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              "${e.length.toString()}字",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      )
                    : const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [CircularProgressIndicator()],
                        ),
                      ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: AppTheme.light.primaryColor))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () async {
                            if (_storyController.currPage.value == 0) {
                              Get.defaultDialog(
                                  title: "提示", middleText: "已经是第一页了");
                              return;
                            }
                            _storyController.updateCurrPage(
                                _storyController.currPage.value - 1);
                          },
                          child: const Text(
                            "上一页",
                            style: TextStyle(fontSize: 18),
                          )),
                      TextButton(
                          onPressed: () async {
                            _storyController.updateCurrPage(
                                _storyController.currPage.value + 1);
                          },
                          child: const Text(
                            "下一页",
                            style: TextStyle(fontSize: 18),
                          ))
                    ],
                  ),
                )
              ],
            )
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()],
              ),
            )),
      floatingActionButton:
          Obx(() => isPlayingVideo.value || isLoadingVideo.value
              ? FloatingActionButton(
                  onPressed: () async {
                    await audioPlayer.stop();
                  },
                  child: isLoadingVideo.value
                      ? const CircularProgressIndicator()
                      : (isPlayingVideo.value
                          ? const Icon(Icons.stop_circle)
                          : const SizedBox()),
                )
              : const SizedBox()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> handleStory(Story story) async {
    logger.f("请求数据:$story");
    isLoadingVideo(true);
    isPlayingVideo(false);
    _currByte.clear();
    StoryDetail detail = await _storyController.getStoryDetail(story.storyId);
    await toTTS("${detail.title}\n${detail.content}");
  }

  Future<void> toTTS(String text) async {
    logger.f("文本:$text");
    await audioPlayer.stop();
    initTTS();
    Map<String, dynamic> param = _xfService.createTTSRequestParam(text: text);
    _xfService.ttsSendText(param);
  }

  // 建立TTS通道连接，并设置监听函数
  void initTTS() {
    _xfService.initConnect();
    _xfService.setupTTSListener((event) => onEvent(event),
        onError: (error) => onError(error), onDone: onDone);
  }

  // 合成后的base64合并并播放
  void onEvent(event) {
    int status = event['status'];

    if (event['audio'] != null) {
      String base64 = event['audio'];
      Uint8List base64Byte = base64Decode(base64);
      _currByte = [..._currByte, ...base64Byte];
    }

    if (status == 2) {
      audioPlayer.play(BytesSource(Uint8List.fromList(_currByte)));
      _currByte.clear();
      isLoadingVideo(false);
      isPlayingVideo(true);
    }
  }

  void onError(error) {
    Get.defaultDialog(
        title: "错误",
        middleText: error.toString(),
        titleStyle: const TextStyle(color: Colors.red));
  }

  void onDone() {
    isLoadingVideo(false);
  }
}
