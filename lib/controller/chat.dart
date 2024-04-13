

import 'package:dart_openai/dart_openai.dart';
import 'package:get/get.dart';
import 'package:sheep/model/message.dart';

class ChatPageController extends GetxController {
  List<Message> messages = [
    Message("hi", OpenAIChatMessageRole.user, 0),
    Message("How can I help you ?", OpenAIChatMessageRole.assistant,1),
    Message("hi", OpenAIChatMessageRole.user, 2),
    Message("How can I help you ?", OpenAIChatMessageRole.assistant,3),
    Message("hi", OpenAIChatMessageRole.user, 4),
    Message("How can I help you ?", OpenAIChatMessageRole.assistant,5),
    Message("hi", OpenAIChatMessageRole.user, 6),
    Message("How can I help you ?", OpenAIChatMessageRole.assistant,7),
    Message("hi", OpenAIChatMessageRole.user, 8),
    Message("How can I help you ?", OpenAIChatMessageRole.assistant,9),
    Message("hi", OpenAIChatMessageRole.user, 0),
    Message("How can I help you ?", OpenAIChatMessageRole.assistant,1),
    Message("hi", OpenAIChatMessageRole.user, 0),
    Message("How can I help you ?", OpenAIChatMessageRole.assistant,1),
    Message("hi", OpenAIChatMessageRole.user, 0),
    Message("How can I help you ?", OpenAIChatMessageRole.assistant,1),
    Message("hi", OpenAIChatMessageRole.user, 0),
    Message("How can I help you ?", OpenAIChatMessageRole.assistant,1),
    Message("hi", OpenAIChatMessageRole.user, 0),
    Message("How can I help you ?", OpenAIChatMessageRole.assistant,1),
  ];
  int len = 1;
}