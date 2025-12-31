import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/colors.dart';
import 'package:gzc_app/core/theme/spacing.dart';

class FeeStandardPage extends StatelessWidget {
  FeeStandardPage({super.key});
  final List<StandedData> feeStandards = [
    StandedData("现场录音", "确认存证且存证成功后根据录音时长计费", "每分钟收费10个币，不足1分钟按1分钟算，证据免费存放3年。"),
    StandedData("手机录像", "确认存证且存证成功后根据录像时长收费", "每分钟收费20个币，不足1分钟按1分钟算，证据免费存放3年。"),
    StandedData("线下证据", "确认存证且存证成功后根据截图张数计费", "计费标准20币/张，证据免费存放3年"),
    StandedData(
      "电话录音",
      "拨通被叫方号码后开始计时：若被叫方接听，则按照拨通至通话结束的时长进行计费并自动存证；被叫方未接听则不计费",
      "每分钟收费10个币，不足1分钟按1分钟收费标准。证据免费存放3年。",
    ),
    StandedData("屏幕录制", "确认存证且存证成功后根据录像时长计费", "每分钟收费20个币，不足1分钟按1分钟算，证据免费存放3年。"),
    StandedData("网页取证", "确认存证且存证成功后根据截图张数计费", "计费标准20币/张，证据免费存放3年"),
  ];
  final List<StandedData> proofService = [
    StandedData("存证证明", "电子数据公证存证证明", "目前免费申请出具"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("收费标准")),
      body: Padding(
        padding: EdgeInsets.all(Spacing.pageHorizontal),
        child: ListView(children: [
          _buildStanded(context, feeStandards),
          SizedBox(height: Spacing.cardGap),
          _buildStanded(context, proofService),
          SizedBox(height: Spacing.cardGap),
          Container(
            padding: EdgeInsets.all(Spacing.cardPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(Spacing.radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("公证服务", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),),
                SizedBox(height: Spacing.cardGap),
                Text("本处将根据具体公证服务内容收取公证费", style: Theme.of(context).textTheme.bodySmall,),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildStanded(BuildContext context, List<StandedData> dataList) {
    int index = 0;
    final int totalLen = dataList.length;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
      ),
      child: Column(
        children: dataList.map((data) {
          index += 1;
          return Container(
            padding: EdgeInsets.all(Spacing.cardPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Spacing.iconXl,
                  width: Spacing.iconXl,
                  decoration: BoxDecoration(
                    color: Color(0xFFE2EEFF),
                    borderRadius: BorderRadius.circular(Spacing.radiusMd),
                  ),
                  child: Icon(
                    Icons.apps_rounded,
                    color: Theme.of(context).colorScheme.surface,
                    size: Spacing.iconMd,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(bottom: Spacing.md),
                    margin: EdgeInsets.only(left: Spacing.md),
                    decoration: index == totalLen ? null : BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: lightGrey, width: 1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(height: Spacing.xs),
                        Text(
                          data.description,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: textSubColor),
                        ),
                        SizedBox(height: Spacing.xs),
                        Text(
                          data.standedDescription,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class StandedData {
  final String title;
  final String description;
  final String standedDescription;

  const StandedData(this.title, this.description, this.standedDescription);
}
