import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheep/component/chat.dart';
import 'package:sheep/controller/chat.dart';

import '../component/drawer.dart';

class ChatPage extends GetResponsiveView<ChatPageController> {
  ChatPage({super.key}) {}

  final _chatPageController = Get.find<ChatPageController>();

  @override
  Widget? builder() {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
          top: BorderSide(
            color: Colors.grey, // 边框颜色
            width: 0.5, // 边框宽度
          ),
        ),
      ),
      drawer: const ConversationWindow(),
      body: _chatPageController.len == 0
          ? const InitChatWindows()
          : ChatWindows(_chatPageController.messages),
      bottomNavigationBar: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.account_circle_rounded,
            size: 30,
          ),
          hintText: "请输入内容以发起对话",
          suffixIcon: GestureDetector(
            child: const Icon(
              Icons.send,
              size: 30,
            ),
            onTap: () => {print("发送")},
          ),
        ),
      ),
    );
  }
}
