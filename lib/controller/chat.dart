import 'package:dart_openai/dart_openai.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:sheep/model/message.dart';

class ChatPageController extends GetxController {
  // var messages = Rx<List<Message>>([]);
  RxList<Message> messages = RxList<Message>([]);
  RxString sendText = RxString("");
  RxString aiResponse = RxString("");
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void addMessage(Message message) {
    messages.add(message);
  }

  void setSendText(String text){
    sendText.value = text;
  }

  void setAIResponse(String text){
    aiResponse.value = text;
  }


}
