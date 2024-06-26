
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:get/get.dart';


// 介绍下自己
class SettingPageController extends GetxController{
  // ------ 系统 设置
  // 主题类型
  final isDarkTheme = false.obs;

  // ------ OpenAI 设置
  // url地址
  final openAIBaseUrl = "https://api.mnzdna.xyz/".obs;
  // key
  final openAIApiKey = "sk-W9kYeExxxxxxxxxxxxxx0353Dc7a".obs;
  // 对话模型
  final chatModel = "gpt-3.5-turbo".obs;
  // 最大聊天记录长度
  final chatLength = 10.obs;
  // 系统提示词
  final systemPrompt = "".obs;
  // 是否开启人设设定(系统提示词)
  final disabledSystemPrompt = false.obs;

  // ------ 科大讯飞 设置
  // 是否开启语音回复
  final disabledXfVoice = true.obs;
  // api
  final xfAppID = "".obs;
  final xfApiSecret = "".obs;
  final xfApiKey = "".obs;
  // 语音模型
  final ttsVCN = "xiaoyan".obs;

  void setOpenAIBaseUrl(String url) async {
    openAIBaseUrl.value = url;
    update();
  }

  void setOpenAIApiKey(String key) async {
    openAIApiKey.value = key;
    update();
  }

  void setChatModel(String model) async {
    chatModel.value = model;
    update();
  }

  void setChatLength(int len) async {
    chatLength.value = len;
    update();
  }

  void setSystemPrompt(String prompt) async {
    systemPrompt.value = prompt;
    update();
  }

  void setDisabledSystemPrompt(bool flag) async {
    disabledSystemPrompt.value = flag;
    update();
  }

  void setDisabledXfVoice (bool flag) async {
    disabledXfVoice.value = flag;
    update();

  }

  void setXfAppID(String appID) async {
    xfAppID.value = appID;
    update();

  }

  void setXfApiSecret(String apiSecret) async {
    xfApiSecret.value = apiSecret;
    update();
  }

  void setXfApiKey(String apiKey) async {
    xfApiKey.value = apiKey;
    update();
  }

  void setVcn(String vcn) async {
    ttsVCN.value = vcn;
    update();
  }


}