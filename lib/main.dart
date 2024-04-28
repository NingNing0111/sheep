import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:sheep/config/base.dart';
import 'package:sheep/config/router/router.dart';
import 'package:sheep/config/theme/theme.dart';
import 'package:sheep/controller/setting.dart';
import 'package:sheep/controller/story.dart';
import 'package:sheep/controller/todo.dart';
import 'package:sheep/model/task.dart';
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
    Get.lazyPut(() => ChatPageController());
    Get.lazyPut(() => StoryPageController());
    Get.lazyPut(() => SettingPageController());
    Get.lazyPut(() => TodoPageController());

    return AdaptiveTheme(
      light: AppTheme.light,
      dark: AppTheme.dark,
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => GetMaterialApp(
        title: BaseConfig.APPLICATION_TITLE,
        theme: theme,
        darkTheme: darkTheme,
        home: const BaseLayout(),
        initialRoute: BaseConfig.BASE_INIT_ROUTER,
        defaultTransition: Transition.rightToLeft,
        getPages: routers,
        debugShowCheckedModeBanner: false,
        unknownRoute: unknown_page,
      ),
    );
  }
}
