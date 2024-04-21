import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          Icon(CupertinoIcons.sparkles,size: 40,color: Colors.black54,),
          SizedBox(height: 20,),
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
