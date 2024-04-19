
import 'package:dart_openai/dart_openai.dart';

// 对话信息实体
class Message {
  Message(this.content,this.role,this.id,this.isAnimation);
  // 内容
  late String content;
  // 角色
  late OpenAIChatMessageRole role;
  // Id
  late int id;
  // 是否动画
  late bool isAnimation;

  @override
  String toString() {
    return 'Message{content: $content, role: $role, id: $id}';
  }
}
