import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    print("Profile Build");
    return Scaffold(
      body: Center(
        child: Text(
          '我的',
          style: Get.textTheme.headlineMedium,
        ),
      ),
    );
  }
}