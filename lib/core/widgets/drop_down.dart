import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gzc_app/core/theme/colors.dart' show surfaceColor, textColor;
import 'package:gzc_app/core/theme/spacing.dart';

class CustomDropDown extends StatefulWidget {
  final Map<String, String> options;
  final double? menuWidth;
  final int menuShowCount;
  final Alignment menuTextAlign;
  final Color boxColor;
  final Color boxTextColor;
  final String hintText;
  final double? boxRadius;
  const CustomDropDown({
    super.key,
    required this.options,
    this.menuShowCount = 5,
    this.menuWidth,
    this.menuTextAlign = Alignment.centerLeft,
    this.boxColor = surfaceColor,
    this.boxTextColor = textColor,
    this.hintText = "请选择",
    this.boxRadius
  }) : assert(menuShowCount <= 10 && menuShowCount > 0);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String _selectedValue = "";
  final double boxHeight = 42.h;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: boxHeight,
      decoration: BoxDecoration(
        color: widget.boxColor,
        borderRadius: BorderRadius.circular(widget.boxRadius ?? Spacing.radiusMd),
      ),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent, // 禁用高亮色
        borderRadius: BorderRadius.circular(widget.boxRadius ?? Spacing.radiusMd),
        onTap: () async {
          // 1. 获取按钮 RenderBox
          final RenderBox buttonBox = context.findRenderObject() as RenderBox;
          if (!buttonBox.attached) return;
      
          // 2. 获取 Overlay 尺寸（用于定位和限制高度）
          final overlay = Overlay.of(context);
          final overlayBox = overlay.context.findRenderObject() as RenderBox;
          final screenSize = overlayBox.size;
      
          // 3. 计算弹窗位置（按钮左下角）
          final buttonTopLeft = buttonBox.localToGlobal(
            Offset.zero,
            ancestor: overlayBox,
          );
          final RelativeRect position = RelativeRect.fromRect(
            Rect.fromLTWH(
              buttonTopLeft.dx,
              buttonTopLeft.dy + buttonBox.size.height + Spacing.listItemGap,
              200,
              0,
            ),
            Offset.zero & screenSize,
          );
      
          final popHeight = 46.h;
          final double menuHeight = widget.options.length <= widget.menuShowCount ? popHeight * widget.options.length + 16 : popHeight * widget.menuShowCount + 16;
      
          final menuWidth = widget.menuWidth ?? buttonBox.size.width;
          final List<PopupMenuEntry<String>> menuItems = widget.options.entries.map((MapEntry<String, String> entry){
            return PopupMenuItem<String>(
              height: popHeight,
              child: Align(alignment: widget.menuTextAlign, child: Text(entry.value)),
              onTap: (){
                setState(() {
                  if (_selectedValue == entry.key) return;
                  _selectedValue = entry.key;
                });
              },
            );
          }).toList();
      
          // 6. 显示菜单
          final String? result = await showMenu<String>(
            context: context,
            position: position,
            items: menuItems,
            clipBehavior: Clip.hardEdge,
            elevation: 2,
            constraints: BoxConstraints(maxWidth: menuWidth, minWidth: menuWidth, minHeight: menuHeight, maxHeight: menuHeight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Spacing.radiusMd),
            ),
            color: Colors.white, // 透明背景，由内部 Material 控制
          );
      
          if (result != null) {
            setState(() {
              _selectedValue = result;
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.cardPadding),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: widget.boxTextColor),
                  widget.options[_selectedValue] ?? widget.hintText,
                ),
              ),
              Icon(Icons.arrow_drop_down_rounded, color: widget.boxTextColor),
            ],
          ),
        ),
      ),
    );
  }
}
