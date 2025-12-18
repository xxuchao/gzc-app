import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String? routeName;

  const ErrorPage({
    super.key,
    this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    final name = routeName ?? "(unknown)";

    return Scaffold(
      appBar: AppBar(
        title: const Text('页面不存在'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '404',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '未找到对应页面',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              Text(
                'route: $name',
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('返回'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
