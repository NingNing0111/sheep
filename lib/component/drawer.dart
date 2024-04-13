import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversationWindow extends StatelessWidget {
  const ConversationWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          border: const Border(right: BorderSide(width: .1))),
      constraints: const BoxConstraints(maxWidth: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(thickness: .5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  label: const Text('开启新对话'),
                  icon: const Icon(Icons.add_box),
                ),
                const SizedBox(
                  height: 6,
                ),
                const SizedBox(
                  height: 6,
                ),
                TextButton.icon(
                  onPressed: () {
                    Get.toNamed('/setting');
                  },
                  label: const Text('设置'),
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
