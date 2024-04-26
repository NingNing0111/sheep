import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:sheep/main.dart';

import '../service/story_service.dart';

class StoryPageController extends GetxController {
  final _storyService =
      StoryService("tmrjavkfqqjnqdlo", "BRLNL8cPsib2hh68gW3EB3CcwdOaTAcK");
  var currPage = 0.obs;
  var storyList = RxList<Story>();
  var storyTypesList = RxList<StoryType>();
  var currType = Rx<StoryType>(StoryType(1,"睡前故事"));
  var isTypeDataRead = false.obs;
  var isStoryDataRead = false.obs;


  @override
  void onInit() async {
    super.onInit();
    await initStoryType();
    await initStoryList();
  }

  Future<void> initStoryType() async {
    isTypeDataRead(false);
    var storyTypes = await _storyService.getStoryType();
    currType.value = storyTypes[0];
    storyTypesList.assignAll(storyTypes);
    isTypeDataRead(true);
    logger.f(storyTypes);
  }

  Future<void> initStoryList() async {
    isStoryDataRead(false);
    storyList.clear();
    List<Story> resStoryList = await _storyService.getStoryList(
        currType.value.typeId, currPage.value);
    storyList.addAll(resStoryList);
    isStoryDataRead(true);
    logger.f(resStoryList);
  }

  void updateCurrType(StoryType type) async {
    isStoryDataRead(false);
    currType.value = type;
    currPage.value = 0;
    await initStoryList();
  }

  void updateCurrPage(int page) async {
    isStoryDataRead(false);
    currPage.value = page;
    await initStoryList();
  }
  
  Future<StoryDetail> getStoryDetail(int storyId) async {
    StoryDetail detail = await _storyService.getStoryDetail(storyId);
    return detail;
  }

}
