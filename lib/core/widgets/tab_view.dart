import 'package:flutter/material.dart';

class CustomTabView extends StatefulWidget {
  final List<Widget> tabs;
  final List<Widget> views;
  final bool isScrollable;
  final Color? indicatorColor;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final EdgeInsetsGeometry? padding;

  const CustomTabView({
    super.key,
    required this.tabs,
    required this.views,
    this.isScrollable = false,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.padding,
  }) : assert(tabs.length == views.length, 'tabs 和 views 长度必须一致');

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: widget.tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: widget.padding,
          child: TabBar(
            controller: _controller,
            tabs: widget.tabs,
            isScrollable: widget.isScrollable,
            indicatorColor: widget.indicatorColor,
            labelColor: widget.labelColor,
            unselectedLabelColor: widget.unselectedLabelColor,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: widget.views,
          ),
        ),
      ],
    );
  }
}