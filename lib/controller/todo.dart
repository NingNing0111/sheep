import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sheep/main.dart';

import '../config/base.dart';
import '../model/task.dart';

class TodoPageController extends GetxController {
  late RxList<Task> todoList;
  final _myBox = Hive.box(BaseConfig.DATABASE_NAME);
  final _DBKEY = "TODOLIST";

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void initData() {
    // 从数据库中加载数据
    List history = _myBox.get(_DBKEY);

    if (history.isEmpty) {
      todoList = RxList([]);
    } else {
      todoList = RxList([]);
      for(Task item in history){
        todoList.add(item);
      }
    }

  }

  void deleteTask(int index) {
    todoList.removeAt(index);
    updateDB();
  }

  void addTask(Task task) {
    todoList.insert(0, task);
    updateDB();
  }

  void updateTaskState(int index) {
    var currTask = todoList[index];
    currTask.state = !currTask.state;
    todoList.removeAt(index);
    todoList.insert(index, currTask);
    updateDB();
  }

  void updateDB() {
    logger.e(todoList);
    _myBox.put(_DBKEY, todoList);
    initData();
  }
}
