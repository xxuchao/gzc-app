import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gzc_app/core/theme/colors.dart';
import 'package:gzc_app/core/widgets/operate_button.dart';
import 'package:gzc_app/core/theme/spacing.dart';

class BottomOperate extends StatelessWidget {
  final List<OperateButtonData> btns;
  final double rate;
  const BottomOperate({
    super.key,
    required this.btns,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    final boxHeight = 56.h;
    final btnHeight = boxHeight - Spacing.smx * 2;
    return Container(
      height: boxHeight,
      padding: EdgeInsets.symmetric(vertical: Spacing.smx),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: surfaceColor,
        boxShadow: [
          BoxShadow(color: secondaryTextColor, blurRadius: 2)
        ]
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final parentWidth = constraints.maxWidth / rate;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: btns.map((data){
              return OperateButton(
                data.text,
                data.onPressed,
                backgroundColor: data.backgroundColor,
                textColor: data.textColor,
                borderRadius: data.borderRadius,
                width: parentWidth,
                height: btnHeight,
                showBorder: data.showBorder,
                borderSide: data.borderSide,
              );
            }).toList()
          );
        },
      ),
    );
  }
}

class OperateButtonData {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final double? width;
  final double? height;
  final bool showBorder;
  final BorderSide? borderSide;
  final VoidCallback onPressed;

  const OperateButtonData(
    this.text,
    this.onPressed,
    {
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.width,
    this.height,
    this.showBorder = false,
    this.borderSide,
  });
}