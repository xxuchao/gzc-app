import 'package:flutter/material.dart';

class CasePage extends StatelessWidget {
  const CasePage({super.key});

  @override
  Widget build(BuildContext context) {
    print("Case Build");
    return Scaffold(
      body: Center(
        child: Text(
          '案件',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}