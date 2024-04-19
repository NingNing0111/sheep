import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatefulWidget {
  final String content;
  final String role;
  final bool isAnimation;

  const ChatItem(
      {super.key,
      required this.content,
      required this.role,
      this.isAnimation = false});

  @override
  State<StatefulWidget> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.role == 'user'
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: widget.role == 'user'
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Icon(
              widget.role == 'user' ? Icons.person : Icons.school,
              color: Colors.teal,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              widget.role.toUpperCase(),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: widget.role == 'user'
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Flexible(
                child: Card(
              margin: const EdgeInsets.all(10),
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: widget.role == 'user'
                      ? SelectableText(
                          widget.content,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )
                      : widget.isAnimation
                          ? AnimatedTextKit(
                              totalRepeatCount: 1,
                              pause: const Duration(seconds: 2),
                              animatedTexts: [
                                TypewriterAnimatedText(widget.content,
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500))
                              ],
                            )
                          : SelectableText(
                              widget.content,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )),
            )),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
