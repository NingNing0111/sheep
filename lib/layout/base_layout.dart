import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheep/page/chat.dart';
import 'package:sheep/page/period.dart';
import 'package:sheep/page/story.dart';
import 'package:sheep/service/assets_service.dart';
import '../config/base.dart';

class BaseLayout extends StatefulWidget {
  const BaseLayout({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BaseLayoutState();
  }
}

class _BaseLayoutState extends State<BaseLayout> {
  final _bottomNavigationBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.adb), label: "对话"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.account_balance_wallet), label: "听故事"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.access_time_filled), label: "经期计算"),
  ];

  final List<Widget> _bottomNavigationBarPage = [
    ChatPage(),
    StoryPage(),
    const PeriodPage()
  ];

  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(BaseConfig.APPLICATION_NAME),
        centerTitle: true,
        leading: InkWell(
          onTap: () => {
            setState(() {
              currIndex = 0;
            })
          },
          child: Image.asset(AssetsManage.sheepLogo),
        ),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 5),
            child: InkWell(
              onTap: () => {Get.toNamed("/setting")},
              child: const Icon(
                Icons.settings,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: _bottomNavigationBarPage[currIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        items: _bottomNavigationBarItems,
        currentIndex: currIndex,
        onTap: onTapChanged,
      ),
    );
  }

  void onTapChanged(int value) {
    setState(() {
      currIndex = value;
    });
  }
}
