import 'package:flutter/material.dart';
import 'package:gzc_app/core/router/app_router.dart';
import 'package:gzc_app/core/theme/colors.dart' show textSubColor;
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/bottom_operate.dart';
import 'package:gzc_app/core/widgets/custom_card.dart';
import 'package:gzc_app/core/widgets/custom_list_tile.dart';
import "package:gzc_app/core/utils/devices.dart";

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double inputWidth = DeviceUtils.screenWidth * 0.4;
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加地址'),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          AppRouter.pop();
        }, icon: Icon(Icons.close)),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: Spacing.pageHorizontal, vertical: Spacing.pageTop),
                children: [
                  // 粘贴自动识别框
                  CustomCard(
                    child: TextField(
                      maxLines: 5, // 设置最大行数（可滚动）
                      minLines: 3, // 设置最小行数（可选）
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline, // 回车换行而不是提交
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: '粘贴自动识别',
                      ),
                    ),
                  ),
                  CustomCard(
                    material: true,
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        CustomListTile(
                          showBottomBorder: true,
                          title: "收件人",
                          trailing: SizedBox(
                            width: inputWidth,
                            child: TextField(
                              style: Theme.of(context).textTheme.bodyMedium,
                              textDirection: TextDirection.rtl, // 强制从左到右
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: '请输入',
                                isDense: true
                              )
                            ),
                          ),
                        ),
                        CustomListTile(
                          showBottomBorder: true,
                          title: "联系方式",
                          trailing: SizedBox(
                            width: inputWidth,
                            child: TextField(
                              style: Theme.of(context).textTheme.bodyMedium,
                              textDirection: TextDirection.rtl, // 强制从左到右
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: '手机号码或者电话号码',
                                isDense: true
                              )
                            ),
                          ),
                        ),
                        CustomListTile(
                          showBottomBorder: true,
                          showTrailingArrow: true,
                          trailing: Text("请选择", style: TextStyle(color: textSubColor),),
                          title: "所在地区",
                          onTap: (){},
                        ),
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric( horizontal: Spacing.pageHorizontal, vertical: Spacing.cardGap),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("详细地址"),
                              SizedBox(height: Spacing.xs,),
                              TextField(
                                style: Theme.of(context).textTheme.bodyMedium,
                                maxLines: 3,
                                minLines: 2,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: '请输入',
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BottomOperate(
              rate: 2,
              btns: [
                OperateButtonData(
                  "保存",
                  () => { print("保存")}
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}