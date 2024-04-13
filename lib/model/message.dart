
import 'package:drift/drift.dart';
import 'package:dart_openai/dart_openai.dart';

// 对话信息实体
class Message {
  Message(this.content,this.role,this.id);
  // 内容
  late String content;
  // 角色
  late OpenAIChatMessageRole role;
  // Id
  late int id;

  @override
  String toString() {
    return 'Message{content: $content, role: $role, id: $id}';
  }
}

// 持久化存储 历史对话
class HistoryChat extends Table {
  // id
  IntColumn get id => integer().autoIncrement()();
  // 历史聊天列表
  TextColumn get messages => text().withLength(min: 0, max:2000)();
  // 角色
  TextColumn get role => text().withLength(min:0,max:15)();
  // 对话标题
  TextColumn get title => text().withLength(min: 0,max: 2000)();
  // 创建时间
  DateTimeColumn get created => dateTime().withDefault(currentDateAndTime)();
}