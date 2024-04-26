import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:sheep/config/base.dart';
import 'package:sheep/config/router/router.dart';
import 'package:sheep/controller/setting.dart';
import 'package:sheep/controller/story.dart';
import 'package:sheep/controller/todo.dart';
import 'package:sheep/model/task.dart';
import 'config/theme/theme.dart';
import 'controller/chat.dart';
import 'layout/base_layout.dart';

final logger = Logger();

void main() async {
  // init the hive
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  // open a box
  await Hive.openBox(BaseConfig.DATABASE_NAME);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Get.lazyPut(()=>ChatPageController());
    Get.lazyPut(()=>StoryPageController());
    Get.lazyPut(()=>SettingPageController());
    Get.lazyPut(() => TodoPageController());
    final _settingController = Get.find<SettingPageController>();


    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      title: BaseConfig.APPLICATION_TITLE,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const BaseLayout(),
      initialRoute: BaseConfig.BASE_INIT_ROUTER,
      defaultTransition: Transition.rightToLeft,
      getPages: routers,
      themeMode: ThemeMode.system,
      unknownRoute: unknown_page,
    );
  }
}

