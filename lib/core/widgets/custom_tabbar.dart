
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gzc_app/core/theme/spacing.dart';

class CustomTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final List<Widget> tabViews;
  final bool isScrollable;
  final EdgeInsetsGeometry? tabBarHorizontalPadding;
  final EdgeInsetsGeometry? labelPadding;
  final double? tabBarHeight;
  final Color? tabBarBackgroundColor;
  final Color? labelColor;
  final Color? indicatorColor;
  final double dividerHeight;
  final EdgeInsetsGeometry? tabBarViewPadding;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.tabViews,
    this.isScrollable = false,
    this.tabBarHorizontalPadding,
    this.labelPadding,
    this.tabBarHeight,
    this.tabBarBackgroundColor,
    this.labelColor,
    this.indicatorColor,
    this.dividerHeight = 0,
    this.tabBarViewPadding,
  }) : assert(tabs.length > 0),
       assert(tabs.length == tabViews.length);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          Container(
            color: tabBarBackgroundColor ?? Theme.of(context).colorScheme.surface,
            padding: tabBarHorizontalPadding,
            child: PreferredSize(
              preferredSize: Size.fromHeight(tabBarHeight ?? 46.h),
              child: TabBar(
                isScrollable: isScrollable,
                tabAlignment: isScrollable ? TabAlignment.start : null,
                labelPadding: labelPadding,
                labelColor: labelColor ?? Theme.of(context).colorScheme.secondary,
                dividerHeight: dividerHeight,
                indicatorColor: indicatorColor  ?? Theme.of(context).colorScheme.secondary,
                tabs: tabs,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(children: tabViews.map((item) {
              return Padding(
                padding: tabBarViewPadding ?? EdgeInsets.only(top: Spacing.pageTop, left: Spacing.pageHorizontal, right: Spacing.pageHorizontal),
                child: item,
              );
            }).toList()),
          ),
        ],
      ),
    );
  }
}
