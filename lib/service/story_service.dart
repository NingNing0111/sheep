import 'dart:math';

import 'package:dio/dio.dart';
import 'package:sheep/main.dart';
import 'package:sheep/model/story.dart';

// GitHub项目：https://github.com/MZCretin/RollToolsApi
// 故事接口：https://www.mxnzp.com/doc/detail?id=38
class _StoryAPI {
  static String type = "https://www.mxnzp.com/api/story/types";
  static String list = "https://www.mxnzp.com/api/story/list";
  static String detail = "https://www.mxnzp.com/api/story/details";
}

class StoryService {
  late String _appID;
  late String _appSecret;
  late Dio _dio;

  StoryService(this._appID, this._appSecret) {
    _dio = Dio();
  }

  // 获取故事类别
  Future<List<StoryType>> getStoryType() async {
    Response resp = await _dio.get(_StoryAPI.type,
        queryParameters: {"app_id": _appID, "app_secret": _appSecret});
    if (resp.data['code'] == 1) {
      var data = resp.data['data'];
      final List<Map<String, dynamic>> dataList =
          List<Map<String, dynamic>>.from(data);
      return dataList.map((data) => StoryType.fromJson(data)).toList();
    }
    return [];
  }

  // 获取故事列表
  Future<List<Story>> getStoryList(int typeId, int page) async {
    Response resp = await _dio.get(_StoryAPI.list, queryParameters: {
      "type_id": typeId,
      "page": page,
      "app_id": _appID,
      "app_secret": _appSecret
    });
    if (resp.data['code'] == 1) {
      var data = resp.data['data'];
      final List<Map<String, dynamic>> dataList =
          List<Map<String, dynamic>>.from(data);
      return dataList.map((data) => Story.fromJson(data)).toList();
    }
    return [];
  }

  // 获取故事详情
  Future<StoryDetail> getStoryDetail(int storyId) async {
    Response resp = await _dio.get(_StoryAPI.detail, queryParameters: {
      "story_id": storyId,
      "app_id": _appID,
      "app_secret": _appSecret
    });
    if (resp.data['code'] == 1) {
      var data = resp.data['data'];
      return StoryDetail.fromJson(data);
    }
    return StoryDetail(-1, "网络错误", "错误", 10, "0", "网络错误");
  }
}

// 类别结果
class StoryType {
  late int typeId;
  late String name;

  StoryType(this.typeId, this.name);

  factory StoryType.fromJson(Map<String, dynamic> json) {
    return StoryType(json['type_id'], json['name']);
  }

  @override
  String toString() {
    return 'StoryType{typeId: $typeId, name: $name}';
  }
}

// 故事概述
class Story {
  late int storyId;
  late String title;
  late String type;
  late int length;
  late String readTime;

  Story(this.storyId, this.title, this.type, this.length, this.readTime);

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(json['storyId'], json['title'], json['type'], json['length'],
        json["readTime"]);
  }

  @override
  String toString() {
    return 'Story{storyId: $storyId, title: $title, type: $type, length: $length, readTime: $readTime}';
  }
}

// 故事详情
class StoryDetail {
  late int storyId;
  late String title;
  late String type;
  late int length;
  late String readTime;
  late String content;

  StoryDetail(this.storyId, this.title, this.type, this.length, this.readTime,
      this.content);

  @override
  String toString() {
    return 'StoryDetail{storyId: $storyId, title: $title, type: $type, length: $length, readTime: $readTime, content: $content}';
  }

  factory StoryDetail.fromJson(Map<String, dynamic> json) {
    return StoryDetail(json["storyId"], json["title"], json["type"],
        json["length"], json["readTime"], json["content"]);
  }
}
