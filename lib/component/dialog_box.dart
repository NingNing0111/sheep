import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sheep/config/theme/theme.dart';

class AddTaskBox extends StatelessWidget {
  final nameController;
  final descriptionController;
  final levelController;
  final Function()? onSave;
  final Function()? onCancel;

  const AddTaskBox(
      {super.key,
      required this.nameController,
      required this.descriptionController,
      required this.levelController,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Column(
      // get user input
      children: [
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
              labelText: "任务名称",
              contentPadding: EdgeInsets.symmetric(vertical: 5)),
        ),
        TextField(
          controller: descriptionController,
          decoration: const InputDecoration(labelText: "描述或备注"),
        ),
        TextField(
          controller: levelController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^[1-9]|10$')),
            // 正则表达式匹配1-10的整数
          ],
          decoration: const InputDecoration(
            labelText: '输入任务等级 0~10',
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(2),
              child: MaterialButton(
                  onPressed: onCancel,
                  color: AppTheme.light.cardColor,
                  child: const Text(
                    "取消",
                  )),
            ),
            // save button
            MaterialButton(
              onPressed: onSave,
              color: AppTheme.light.primaryColor,
              child: const Text("添加"),
            ),
          ],
        )
      ],
    );
  }
}
