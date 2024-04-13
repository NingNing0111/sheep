import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheep/model/story.dart';

class StoryCard extends StatefulWidget {
  StoryCard(this.story, {super.key});

  late Story story;

  @override
  State<StatefulWidget> createState() {
    return _StoryCardState();
  }
}

class _StoryCardState extends State<StoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.story.image),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(

                boxShadow: [
                  BoxShadow(
                      color: !Get.isDarkMode ? Colors.white70 : Colors.black54,
                      offset: const Offset(0.6, 0.5),
                      blurRadius: 1.0)
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.story.category,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    " | ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "《${widget.story.title}》",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
