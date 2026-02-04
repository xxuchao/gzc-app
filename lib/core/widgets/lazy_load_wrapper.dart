import 'package:flutter/material.dart';

class LazyLoadWrapper extends StatefulWidget {
  final Widget child;
  const LazyLoadWrapper({super.key, required this.child});

  @override
  State<LazyLoadWrapper> createState() => _LazyLoadWrapperState();
}

class _LazyLoadWrapperState extends State<LazyLoadWrapper> {
  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    // 只有当页面第一次被激活时，才改变状态
    if (!_loaded) _loaded = true; 
    return _loaded ? widget.child : const SizedBox.shrink();
  }
}