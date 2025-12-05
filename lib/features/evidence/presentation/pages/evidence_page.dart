import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EvidencePage extends StatelessWidget {
  const EvidencePage({super.key});

  @override
  Widget build(BuildContext context) {
    print("Evidence Build");
    return Scaffold(
      body: Center(
        child: Text(
          '证据',
          style: Get.textTheme.headlineMedium,
        ),
      ),
    );
  }
}