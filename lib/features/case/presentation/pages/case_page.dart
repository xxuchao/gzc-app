import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CasePage extends StatelessWidget {
  const CasePage({super.key});

  @override
  Widget build(BuildContext context) {
    print("Case Build");
    return Scaffold(
      body: Center(
        child: Text(
          '案件',
          style: Get.textTheme.headlineMedium,
        ),
      ),
    );
  }
}