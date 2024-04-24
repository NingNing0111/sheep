import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  late String taskName;
  @HiveField(1)
  late String description;
  @HiveField(2)
  late int level;
  @HiveField(3)
  late bool state;
  @HiveField(4)
  late DateTime createTime;

  Task(
      this.taskName, this.description, this.level, this.state, this.createTime);

  @override
  String toString() {
    return 'Task{taskName: $taskName, description: $description, level: $level, state: $state, createTime: $createTime}';
  }
}