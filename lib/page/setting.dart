import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sheep/config/theme/theme.dart';
import 'package:sheep/controller/setting.dart';

class SettingPage extends GetResponsiveView<SettingPageController> {
  SettingPage({super.key});

  final _settingController = Get.find<SettingPageController>();

  final _showOpenAIKey = false.obs;
  final _showXfAppID = false.obs;
  final _showXfSecret = false.obs;
  final _showXfKey = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("设置中心"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            const Divider(),
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "系统设置",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: RadioListTile(
                                  title: const Text("系统"),
                                  value: ThemeMode.system,
                                  groupValue:
                                      _settingController.themeMode.value,
                                  onChanged: (value) {
                                    _settingController
                                        .setThemMode(ThemeMode.system);
                                  })),
                          Expanded(
                              child: RadioListTile(
                                  title: const Text("白天"),
                                  value: ThemeMode.light,
                                  groupValue:
                                      _settingController.themeMode.value,
                                  onChanged: (value) {
                                    _settingController
                                        .setThemMode(ThemeMode.light);
                                  })),
                          Expanded(
                              child: RadioListTile(
                                  title: const Text("黑夜"),
                                  value: ThemeMode.dark,
                                  groupValue:
                                      _settingController.themeMode.value,
                                  onChanged: (value) {
                                    _settingController
                                        .setThemMode(ThemeMode.dark);
                                  })),
                        ],
                      ))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "OpenAI设置",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Obx(() => Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                hintText:
                                    _settingController.openAIBaseUrl.value,
                                label: const Text("API")),
                            initialValue:
                                _settingController.openAIBaseUrl.value,
                            onChanged: (value) =>
                                _settingController.setOpenAIBaseUrl(value),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _showOpenAIKey.value =
                                        !_showOpenAIKey.value;
                                  },
                                  icon: Icon(!_showOpenAIKey.value
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                hintText: _settingController.openAIApiKey.value,
                                label: const Text("Key")),
                            initialValue: _settingController.openAIApiKey.value,
                            obscureText: _showOpenAIKey.value,
                            onChanged: (value) =>
                                _settingController.setOpenAIApiKey(value),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "聊天模型",
                                style: TextStyle(fontSize: 16),
                              ),
                              DropdownButton<String>(
                                value: "gpt-3.5-turbo",
                                items: const [
                                  DropdownMenuItem(
                                      value: "gpt-3.5-turbo",
                                      child: Text("gpt-3.5-turbo")),
                                  DropdownMenuItem(
                                      value: "gpt-4.0", child: Text("gpt-4.0"))
                                ],
                                onChanged: (Object? value) {},
                              )
                            ],
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: _settingController.chatLength.value
                                    .toString(),
                                label: const Text("最大聊天长度")),
                            initialValue:
                                _settingController.chatLength.value.toString(),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (value) => _settingController
                                .setChatLength(int.parse(value)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "开启AI系统设定",
                                style: TextStyle(fontSize: 16),
                              ),
                              Switch(
                                  value: _settingController
                                      .disabledSystemPrompt.value,
                                  onChanged: (value) {
                                    _settingController
                                            .disabledSystemPrompt.value =
                                        !_settingController
                                            .disabledSystemPrompt.value;
                                  }),
                            ],
                          ),
                          _settingController.disabledSystemPrompt.value
                              ? TextFormField(
                                  decoration: InputDecoration(
                                      hintText:
                                          _settingController.systemPrompt.value,
                                      label: const Text("系统提示词")),
                                  initialValue:
                                      _settingController.systemPrompt.value,
                                  onChanged: (value) =>
                                      _settingController.setSystemPrompt(value),
                                )
                              : const SizedBox(),
                        ],
                      ))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "科大讯飞设置",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Obx(() => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "开启语音回复",
                                style: TextStyle(fontSize: 16),
                              ),
                              Switch(
                                  value:
                                      _settingController.disabledXfVoice.value,
                                  onChanged: (value) {
                                    _settingController.disabledXfVoice.value =
                                        !_settingController
                                            .disabledXfVoice.value;
                                  }),
                            ],
                          ),
                          _settingController.disabledXfVoice.value
                              ? SizedBox(
                                  child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              _showXfAppID.value =
                                                  !_showXfAppID.value;
                                            },
                                            icon: Icon(!_showXfAppID.value
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                          ),
                                          hintText:
                                              _settingController.xfAppID.value,
                                          label: const Text("AppID")),
                                      initialValue:
                                          _settingController.xfAppID.value,
                                      obscureText: _showXfAppID.value,
                                      onChanged: (value) =>
                                          _settingController.setXfAppID(value),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              _showXfSecret.value =
                                                  !_showXfSecret.value;
                                            },
                                            icon: Icon(!_showXfSecret.value
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                          ),
                                          hintText: _settingController
                                              .xfApiSecret.value,
                                          label: const Text("ApiSecret")),
                                      initialValue:
                                          _settingController.xfApiSecret.value,
                                      obscureText: _showXfSecret.value,
                                      onChanged: (value) => _settingController
                                          .setXfApiSecret(value),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              _showXfKey.value =
                                                  !_showXfKey.value;
                                            },
                                            icon: Icon(!_showXfKey.value
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                          ),
                                          hintText:
                                              _settingController.xfApiKey.value,
                                          label: const Text("ApiKey")),
                                      initialValue:
                                          _settingController.xfApiKey.value,
                                      obscureText: _showXfKey.value,
                                      onChanged: (value) =>
                                          _settingController.setXfApiKey(value),
                                    ),
                                  ],
                                ))
                              : const SizedBox()
                        ],
                      ))
                ],
              ),
            ),
          ],
        ));
  }
}
