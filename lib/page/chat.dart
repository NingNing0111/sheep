import 'dart:convert';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheep/component/chat.dart';
import 'package:sheep/component/chat_item.dart';
import 'package:sheep/config/theme/theme.dart';
import 'package:sheep/controller/chat.dart';
import 'package:sheep/controller/setting.dart';
import 'package:sheep/model/message.dart';
import 'package:sheep/service/iflytek_service.dart';
import 'package:sheep/service/openai_service.dart';

import '../main.dart';

class ChatPage extends GetResponsiveView<ChatPageController> {
  late final ChatPageController _chatPageController;
  late final SettingPageController _settingController;

  ChatPage({super.key}) {
    _chatPageController = Get.find<ChatPageController>();
    _settingController = Get.find<SettingPageController>();
  }

  // 创建一个 ScrollController
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  late final OpenAIService _openAIService = OpenAIService(
      token: _settingController.openAIApiKey.value,
      url: _settingController.openAIBaseUrl.value);
  late final XfService _xfService = XfService(
      appId: _settingController.xfAppID.value,
      apiSecret: _settingController.xfApiSecret.value,
      apiKey: _settingController.xfApiKey.value);

  final AudioPlayer audioPlayer = AudioPlayer();
  List<int> _currByte = [];
  var isWait = false.obs;

  @override
  Widget? builder() {
    return Scaffold(
        body: Obx(() {
          if (_chatPageController.messages.isEmpty) {
            return const InitChatWindows();
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.hasClients) {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            });
            return ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {
                final currMessage = _chatPageController.messages[index];
                var chatItem = ChatItem(
                  content: currMessage.content,
                  role: currMessage.role.name,
                  isAnimation: currMessage.isAnimation,
                );
                _chatPageController.messages[index].isAnimation = false;
                return chatItem;
              },
              itemCount: _chatPageController.messages.length,
            );
          }
        }),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                prefixIcon: GestureDetector(
                  child: const Icon(
                    Icons.cleaning_services_outlined,
                  ),
                  onTap: () {
                    if(_chatPageController.messages.isNotEmpty){
                      Get.defaultDialog(
                          title: "对话记录删除",
                          middleText: "确定清空所有对话信息吗？",
                          onCancel: () {
                            Get.back();
                          },
                          onConfirm: () {
                            _chatPageController.messages.clear();
                            Get.back();
                          },
                          textCancel: "取消",
                          textConfirm: "确定");
                    }
                  },
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                hintText: "请输入内容以发起对话",
                suffixIcon: Obx(() => isWait.value
                    ? const Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(),
                      )
                    : GestureDetector(
                        onTap: sendMessage,
                        child: const Icon(
                          Icons.send,
                          size: 30,
                        ))),
                filled: true,
                fillColor: Colors.pink[150],
              ),
            )));
  }

  Future<void> sendMessage() async {
    isWait.value = true;
    // key为空
    if (_settingController.openAIApiKey.value.isEmpty) {
      Get.defaultDialog(
        title: "配置错误",
        middleText: "检测到您未设置Key，请前往设置",
        onConfirm: () => Get.back(),
      );
      return;
    }
    // 如果开启了语音回复
    if (_settingController.disabledXfVoice.value &&
        (_settingController.xfAppID.value.isEmpty ||
            _settingController.xfApiSecret.value.isEmpty ||
            _settingController.xfApiKey.value.isEmpty)) {
      Get.defaultDialog(
        title: "配置错误",
        middleText: "检测到您开启了语音回复，但未配置相关信息",
        onConfirm: () => Get.back(),
      );
      return;
    }
    final String sendText = _textEditingController.text;
    if (sendText.isEmpty) {
      Get.defaultDialog(
        title: "发送失败",
        middleText: "发送内容不能为空",
      );
      return;
    }
    _chatPageController.setSendText(_textEditingController.text);
    _textEditingController.text = "";

    // 添加用户输入
    _chatPageController.addMessage(Message(
        _chatPageController.sendText.value,
        OpenAIChatMessageRole.user,
        _chatPageController.messages.length + 1,
        false));
    var chatResponse = await _openAIService.simpleChat(sendText);
    logger.f("AI回复内容:$chatResponse");
    _chatPageController.setAIResponse(chatResponse);
    if (!_settingController.disabledXfVoice.value) {
      _chatPageController.addMessage(Message(
          _chatPageController.aiResponse.value,
          OpenAIChatMessageRole.assistant,
          _chatPageController.messages.length + 1,
          true));
      isWait.value = false;
    } else {
      await toTTS(chatResponse); //
    }
  }

  Future<void> toTTS(String text) async {
    await audioPlayer.stop();
    initTTS();
    Map<String, dynamic> param = _xfService.createTTSRequestParam(
        text: text, vcn: _settingController.ttsVCN.value);
    _xfService.ttsSendText(param);
  }

  // 建立TTS通道连接，并设置监听函数
  void initTTS() {
    _xfService.initConnect();
    _xfService.setupTTSListener((event) => onEvent(event));
  }

  // 合成后的base64合并并播放
  void onEvent(event) {
    logger.f(event);
    int status = event['status'];
    if (event['audio'] != null) {
      String base64 = event['audio'];
      Uint8List base64Byte = base64Decode(base64);
      _currByte = [..._currByte, ...base64Byte];
    }
    if (status == 2) {
      audioPlayer.play(BytesSource(Uint8List.fromList(_currByte)));
      _currByte.clear();
      _currByte = [];
      _chatPageController.addMessage(Message(
          _chatPageController.aiResponse.value,
          OpenAIChatMessageRole.assistant,
          _chatPageController.messages.length + 1,
          true));
      isWait.value = false;
    }
  }
}
