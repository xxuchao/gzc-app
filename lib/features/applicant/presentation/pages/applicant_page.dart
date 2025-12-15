import 'package:flutter/material.dart';

class ApplicantPage extends StatelessWidget {
  const ApplicantPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("Applicant Build");
    return Scaffold(
      body: Center(
        child: Text(
          '申办',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}