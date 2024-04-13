import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/message.dart';

class InitChatWindows extends StatefulWidget {
  const InitChatWindows({super.key});

  @override
  State<StatefulWidget> createState() {
    return _InitChatWindowsState();
  }
}

class _InitChatWindowsState extends State<InitChatWindows> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.sparkles),
          Text(
            "How can I help you today?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          )
        ],
      ),
    );
  }
}

class ChatWindows extends StatefulWidget {
  ChatWindows(this.messages, {super.key});
  late List<Message> messages;

  @override
  State<StatefulWidget> createState() {
    return _ChatWindowsState();
  }

}

class _ChatWindowsState extends State<ChatWindows> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: widget.messages.length,itemBuilder: (context, index) {
      return _buildMessageCard(widget.messages[index]);
    },);
  }

  Widget _buildMessageCard (Message message){
    if(message.role == OpenAIChatMessageRole.user){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.person),
              const SizedBox(
                width: 5,
              ),
              Text(message.role.name.toUpperCase()),
              const SizedBox(width: 10,)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableText(
                    message.content
                  ),
                ),
              ))
            ],
          )
        ],
      );
    }else{
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.school),
                const SizedBox(
                  width: 5,
                ),
                Text(message.role.name.toUpperCase())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SelectableText(
                        message.content
                    ),

                  ),
                ))
              ],
            )
          ],
        );
    }
  }
}