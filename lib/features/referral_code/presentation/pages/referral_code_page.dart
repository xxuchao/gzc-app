import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/custom_card.dart';
import 'package:gzc_app/core/widgets/custom_list_tile.dart';
import 'package:gzc_app/core/widgets/operate_button.dart';

class ReferralCodePage extends StatefulWidget {
  const ReferralCodePage({super.key});

  @override
  State<ReferralCodePage> createState() => _ReferralCodePageState();
}

class _ReferralCodePageState extends State<ReferralCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("推荐码"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: Spacing.pageTop, left: Spacing.pageHorizontal, right: Spacing.pageHorizontal),
        child: Column(
          children: [
            CustomCard(
              padding: EdgeInsets.zero,
              child: CustomListTile(
                title: "我的推荐码",
                trailing: Text("XXXXX"),
              ),
            ),
            CustomCard(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Spacing.cardPadding,
              children: [
                Text("输入推荐码(认证后7天内显示，7天后消失)"),
                TextFormField(
                  // controller: _controller,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    hintText: '请输入推荐码',
                    contentPadding: EdgeInsets.symmetric(horizontal: Spacing.inputPadding, vertical: Spacing.listItemGap),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: Spacing.pageBottom,),
                Align(
                  alignment: Alignment.center,
                  child: OperateButton(
                    width: 150.w,
                    "确认",
                    (){}
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}