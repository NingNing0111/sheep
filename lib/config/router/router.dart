import "package:get/get.dart";
import "package:sheep/layout/base_layout.dart";
import "package:sheep/page/chat.dart";
import "package:sheep/page/period.dart";
import "package:sheep/page/setting.dart";
import "package:sheep/page/story.dart";
import "package:sheep/page/todo.dart";
import "package:sheep/page/unknown.dart";

final routers = [
  GetPage(name: "/",page: () => BaseLayout()),
  GetPage(name: "/chat", page: () => ChatPage()),
  GetPage(name: "/setting", page: () => SettingPage()),
  GetPage(name: "/period", page: () =>  PeriodPage()),
  GetPage(name: "/story", page: () => StoryPage()),
  GetPage(name: "/todo", page: ()=>TodoPage()),
];

final unknown_page = GetPage(name: "/404", page: () => const UnknownRoutePage());

