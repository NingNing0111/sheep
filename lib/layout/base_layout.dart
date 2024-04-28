import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sheep/page/chat.dart';
import 'package:sheep/page/story.dart';
import 'package:sheep/page/todo.dart';
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
    BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage(AssetsManage.chatBottom),
          size: 30,
        ),
        label: "对话"),
    BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage(AssetsManage.storyBottom),
          size: 30,
        ),
        label: "听故事"),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.today_outlined,
          size: 30,
        ),
        label: "Todo")
    // const BottomNavigationBarItem(
    //     icon: Icon(Icons.access_time_filled), label: "经期计算"),
  ];

  final List<Widget> _bottomNavigationBarPage = [
    ChatPage(),
    StoryPage(),
    TodoPage(),
    // const PeriodPage()
  ];

  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AdaptiveTheme.of(context).theme.primaryColor,
        title: Text(
          BaseConfig.APPLICATION_NAME,
          style: AdaptiveTheme.of(context).theme.textTheme.headlineMedium
        ),
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
                color: Colors.white,
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
