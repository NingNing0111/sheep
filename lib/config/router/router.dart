import "package:get/get.dart";
import "package:sheep/layout/base_layout.dart";
import "package:sheep/page/chat.dart";
import "package:sheep/page/period.dart";
import "package:sheep/page/setting.dart";
import "package:sheep/page/story.dart";
import "package:sheep/page/unknown.dart";

final routers = [
  GetPage(name: "/",page: () => const BaseLayout()),
  GetPage(name: "/chat", page: () => ChatPage()),
  GetPage(name: "/setting", page: () => const SettingPage()),
  GetPage(name: "/period", page: () => const PeriodPage()),
  GetPage(name: "/story", page: () => StoryPage())
];

final unknown_page = GetPage(name: "/404", page: () => const UnknownRoutePage());

