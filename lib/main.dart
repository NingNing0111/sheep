import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sheep/config/base.dart';
import 'package:sheep/config/router/router.dart';
import 'package:sheep/controller/story.dart';
import 'config/theme/theme.dart';
import 'controller/chat.dart';
import 'layout/base_layout.dart';

final logger = Logger();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(ChatPageController());
    Get.put(StoryPageController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: BaseConfig.APPLICATION_TITLE,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const BaseLayout(),
      initialRoute: BaseConfig.BASE_INIT_ROUTER,
      defaultTransition: Transition.rightToLeft,
      getPages: routers,
      unknownRoute: unknown_page,
    );
  }
}

