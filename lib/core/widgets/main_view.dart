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
      // body: pages[currentIndex],
      body: IndexedStack(
        index: currentIndex,
        children: List.generate(pages.length, (index){
          return _ActivatedPage(
            index: index,
            currentIndex: currentIndex,
            child: SafeArea(bottom: true, child: pages[index],),
          );
        }),
      ),
    
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

// 辅助组件：记录哪些页面被激活过
class _ActivatedPage extends StatefulWidget {
  final int index;
  final int currentIndex;
  final Widget child;
  const _ActivatedPage({required this.index, required this.currentIndex, required this.child});

  @override
  State<_ActivatedPage> createState() => _ActivatedPageState();
}

class _ActivatedPageState extends State<_ActivatedPage> {
  bool _hasBeenActivated = false;

  @override
  Widget build(BuildContext context) {
    if (widget.index == widget.currentIndex && !_hasBeenActivated) {
      _hasBeenActivated = true;
    }
    if (_hasBeenActivated) {
      return widget.child;
    } else {
      return const SizedBox.shrink(); // 未访问过的页面暂时不渲染
    }
  }
}