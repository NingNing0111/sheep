
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/period.dart';

class PeriodPage extends GetView<PeriodPageController> {
  const PeriodPage({super.key});


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Period")
          ],
        ),
      ),
    );
  }

}