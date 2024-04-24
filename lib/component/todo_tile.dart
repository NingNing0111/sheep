import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../model/task.dart';

class ToDoTile extends StatelessWidget {
  late Task task;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.task,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              spacing: 1,
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.pink[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "创建时间: ${task.createTime.month} - ${task.createTime.day} ${task.createTime.hour}:${task.createTime.minute}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "任务等级: ${task.level}",
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              Row(
                children: [
                  Transform.scale(
                    scale: 1.2, // 设置大小的比例，例如1.5表示增大1.5倍
                    child: Checkbox(
                      value: task.state,
                      onChanged: onChanged,
                      activeColor: Colors.black,
                    ),
                  ),
                  // task name
                  Expanded(
                    child: Text(
                      task.taskName,
                      style: TextStyle(
                          decoration: task.state
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          fontSize: 18),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              Text(
                "备注: ${task.description}",
                style: const TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
