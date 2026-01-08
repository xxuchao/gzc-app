import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/custom_card.dart';
import 'package:gzc_app/core/widgets/custom_list_tile.dart';
import 'package:gzc_app/core/widgets/custom_tabbar.dart';
import 'package:gzc_app/core/widgets/select_chip_group.dart';
import 'package:gzc_app/core/widgets/title_tile.dart';
import 'package:timeline_tile/timeline_tile.dart';
// import 'package:timelines_plus/timelines_plus.dart';

class CaseDetailPage extends StatefulWidget {
  const CaseDetailPage({super.key});

  @override
  State<CaseDetailPage> createState() => _CaseDetailPageState();
}

class _CaseDetailPageState extends State<CaseDetailPage> {
  final List<Tab> tabs = [
    Tab(text: "基本信息"),
    Tab(text: "案件协作"),
    Tab(text: "流程取证"),
    Tab(text: "案件出证"),
  ];
  final List<String> baseInfoSelects = ['案件基础信息', '案件特殊信息'];
  String baseInfoSelect = "案件基础信息";

  final List<String> baseInfoSteps = ["123", "123", "123", "123", "123"];

  final List<BaseInfoData> baseInfoData = [
    BaseInfoData(
      title: "案件编号：20250905170220885000001",
      border: true,
      trailing: TextButton(onPressed: () {}, child: Text("复制")),
    ),
    BaseInfoData(
      title: "案件名称：案件名称案件名称案件名称案件名称",
      border: true,
      trailing: Icon(Icons.edit_note_outlined, size: Spacing.iconMd),
    ),
    BaseInfoData(title: "案件类型：一级/二级", border: true),
    BaseInfoData(title: "创建时间：2025-06-19 17:50:04", border: true),
    BaseInfoData(title: "案件创建人：彭于晏", border: true),
    BaseInfoData(
      title: "案件说明：",
      border: false,
      trailing: Icon(Icons.edit_note_outlined, size: Spacing.iconMd),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("案件详情"),
        actions: [TextButton(onPressed: () {}, child: Text("更多"))],
      ),
      body: CustomTabBar(
        tabs: tabs,
        tabViews: [
          _buildBaseInfo(context),
          _buildCaseCooperation(context),
          _buildProcessEvidence(context),
          _buildCaseIssue(context),
        ],
      ),
    );
  }

  // 基本信息
  Widget _buildBaseInfo(BuildContext context) {
    return ListView(
      children: [
        CustomCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableChipGroup(
                items: baseInfoSelects,
                initialValue: baseInfoSelects[0],
                onChanged: (String? value) {
                  setState(() {
                    if (value != null) baseInfoSelect = value;
                  });
                },
              ),
              if (baseInfoSelect == baseInfoSelects[0]) ...[
                TitleTile(title: "案件基础信息"),
                ...baseInfoData.map((item) {
                  return CustomListTile(
                    horizontalPadding: 0,
                    title: item.title,
                    showBottomBorder: item.border,
                    trailing: item.trailing,
                  );
                }),
                Text(
                  "xxxxxxxxxxxxxxasdfsdfsdfasxxxxxxxxxxxxxxxxxxxasdfsdfsdfasxxxxxxxxxxxxxxxxxxxasdfsdfsdfasxxxxxxxxxxxxxxxxxxx",
                ),
              ],
              if (baseInfoSelect == baseInfoSelects[1]) ...[
                TitleTile(title: "通用信息"),
                CustomListTile(
                  horizontalPadding: 0,
                  title: "工作提醒",
                  trailing: InkWell(
                    onTap: () {
                      print(123);
                    },
                    child: Text("添加"),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (baseInfoSelect == baseInfoSelects[1])
          CustomCard(
            child: Column(
              children: [TitleTile(title: "取证流程信息",), ...List.generate(baseInfoSteps.length, (index) {
                final step = baseInfoSteps[index];
                final isLast = index == baseInfoSteps.length - 1;
                return TimelineTile(
                  lineXY: 1,
                  alignment: TimelineAlign.start,
                  isFirst: index == 0,
                  isLast: isLast,
                  beforeLineStyle: const LineStyle(
                    color: Colors.blue,
                    thickness: 2,
                  ),
                  afterLineStyle: isLast
                      ? null
                      : const LineStyle(color: Colors.blue, thickness: 2),
                  indicatorStyle: IndicatorStyle(
                    width: Spacing.iconMd,
                    color: Colors.blue,
                  ),
                  endChild: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 100,
                    color: Colors.amber,
                  ),
                );
              })],
            ),
          ),
      ],
    );
  }

  // 案件协作
  Widget _buildCaseCooperation(BuildContext context) {
    return Container();
  }

  // 流程取证
  Widget _buildProcessEvidence(BuildContext context) {
    return Container();
  }

  // 案件出证
  Widget _buildCaseIssue(BuildContext context) {
    return Container();
  }
}

class BaseInfoData {
  final String title;
  final Widget? trailing;
  final bool border;
  BaseInfoData({required this.title, this.trailing, this.border = true});
}
