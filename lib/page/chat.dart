import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheep/component/chat.dart';
import 'package:sheep/component/chat_item.dart';
import 'package:sheep/controller/chat.dart';
import 'package:sheep/model/message.dart';
import 'package:sheep/service/iflytek_service.dart';
import 'package:sheep/service/openai_service.dart';

import '../main.dart';

class ChatPage extends GetResponsiveView<ChatPageController> {
  ChatPage({super.key});

  final _chatPageController = Get.find<ChatPageController>();

  // 创建一个 ScrollController
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  static const String token =
      "sk-W9kYeE3JfWM86sr66xxxxxxxxxxxxxxxB96fAd460353Dc7a";
  static const String url = "https://api.mnzdna.xyz/";
  static const String appId = "xxx";
  static const String apiSecret = "xxx";
  static const String apiKey = "xxx";
  final OpenAIService _openAIService = OpenAIService(token: token, url: url);
  final XfService _xfService =
      XfService(appId: appId, apiSecret: apiSecret, apiKey: apiKey);

  final AudioPlayer audioPlayer = AudioPlayer();
  List<int> _currByte = []; // 介绍下四大名著

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
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintText: "请输入内容以发起对话",
              suffixIcon: GestureDetector(
                  onTap: sendMessage,
                  child: const Icon(
                    Icons.send,
                    size: 30,
                  )),
              filled: true,
              fillColor: Colors.blueGrey,
            ),
          ),
        ));
  }

  Future<void> sendMessage() async {
    final String sendText = _textEditingController.text;
    if (sendText.isEmpty) {
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
    _chatPageController.setAIResponse(chatResponse);
    log(chatResponse);
    await toTTS(chatResponse); //
  }

  Future<void> toTTS(String text) async {
    await audioPlayer.stop();
    initTTS();
    Map<String, dynamic> param = _xfService.createTTSRequestParam(text: text);
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
    String base64 = event['audio'];
    Uint8List base64Byte = base64Decode(base64);
    _currByte = [..._currByte, ...base64Byte];
    if (status == 2) {
      audioPlayer.play(BytesSource(Uint8List.fromList(_currByte)));
      _currByte.clear();
      _currByte = [];
      _chatPageController.addMessage(Message(
          _chatPageController.aiResponse.value,
          OpenAIChatMessageRole.assistant,
          _chatPageController.messages.length + 1,
          true));
    }
  }
}
