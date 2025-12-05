import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicantPage extends StatelessWidget {
  const ApplicantPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("Applicant Build");
    return Scaffold(
      body: Center(
        child: Text(
          '申办',
          style: Get.textTheme.headlineMedium,
        ),
      ),
    );
  }
}