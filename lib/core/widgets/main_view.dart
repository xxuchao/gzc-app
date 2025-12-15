import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gzc_app/main_controller.dart';

class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(mainCurrentIndexProvider);
    final pages = ref.watch(mainPagesProvider);

    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) =>
            ref.read(mainCurrentIndexProvider.notifier).setIndex(index),

        type: BottomNavigationBarType.fixed,

        // 设置 BottomNavigationBarItem
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monochrome_photos),
            label: '证据',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dns),
            label: '案件',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.design_services),
            label: '申办',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}