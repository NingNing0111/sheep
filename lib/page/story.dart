import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheep/component/story.dart';
import 'package:sheep/controller/story.dart';

import '../model/story.dart';

class StoryPage extends GetView<StoryPageController> {
  final _storyController = Get.find<StoryPageController>();

  StoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
            itemCount: _storyController.stories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 每行 2 个子项
              crossAxisSpacing: 3, // 子项之间的水平间距
              mainAxisSpacing: 3, // 子项之间的垂直间距
              childAspectRatio: 4 / 5, // 子项宽高比
            ),
            itemBuilder: (context, index) {
              return _initStoryCard(_storyController.stories[index]);
            }));
  }

  Widget _initStoryCard(Story story) {
    return StoryCard(story);
  }
}
