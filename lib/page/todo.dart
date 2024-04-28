import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheep/component/todo_tile.dart';
import 'package:sheep/controller/todo.dart';
import 'package:sheep/model/task.dart';

import '../component/dialog_box.dart';

class TodoPage extends GetView<TodoPageController> {
  TodoPage({super.key});

  final todoController = Get.find<TodoPageController>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final levelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: toAddTask,
          backgroundColor: AdaptiveTheme.of(context).theme.cardColor,
          child: const Icon(Icons.add),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: todoController.todoList.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return ToDoTile(
                    task: todoController.todoList[index],
                    onChanged: (value) => checkBoxChanged(value, index),
                    deleteFunction: (context) =>
                        todoController.deleteTask(index),
                  );
                },
                itemCount: todoController.todoList.length,
              )
            : const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "暂时没有待做的任务",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              )));
  }

  void checkBoxChanged(bool? value, int index) {
    todoController.updateTaskState(index);
  }

  void toAddTask() {
    Get.defaultDialog(
        title: "添加任务清单",
        content: AddTaskBox(
          nameController: nameController,
          descriptionController: descriptionController,
          levelController: levelController,
          onSave: () {
            var taskName = nameController.text;
            var taskDescription = descriptionController.text;
            var taskLevel = levelController.text;
            if (taskName.isEmpty) {
              Get.defaultDialog(title: "添加失败", middleText: "任务名称不能为空");
              return;
            }
            if (taskLevel.isEmpty) {
              Get.defaultDialog(title: "添加失败", middleText: "任务等级不能为空");
              return;
            }
            if (taskDescription.isEmpty) {
              taskDescription = "空";
            }
            todoController.addTask(Task(taskName, taskDescription,
                int.parse(taskLevel), false, DateTime.now()));
            nameController.clear();
            descriptionController.clear();
            levelController.clear();
            Get.back();
          },
          onCancel: () {
            Get.back();
          },
        ));
  }
}
