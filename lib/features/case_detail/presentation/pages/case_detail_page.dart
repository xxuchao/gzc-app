import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/bottom_operate.dart';
import 'package:gzc_app/core/widgets/custom_card.dart';
import 'package:gzc_app/core/widgets/custom_list_tile.dart';
import 'package:gzc_app/core/widgets/custom_tabbar.dart';
import 'package:gzc_app/core/widgets/select_chip_group.dart';
import 'package:gzc_app/core/widgets/title_tile.dart';
import 'package:gzc_app/features/case/presentation/widgets/case_info.dart';
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

  final List<String> cooperationSelects = ['案件协作人', '参与公证人员', '参与公证员'];
  String cooperationSelect = "案件协作人";
  bool _preventDeletion = true;
  final List<CooperationData> cooperationData = [
    CooperationData(
      name: "张三",
      identity: "协作人",
      storageQuantity: 1,
      authorization: false,
    ),
    CooperationData(
      name: "李四",
      identity: "创建人",
      storageQuantity: 2,
      authorization: false,
    ),
    CooperationData(
      name: "王五",
      identity: "协作人",
      storageQuantity: 3,
      authorization: false,
      hasAuth: false,
    ),
  ];
  final List<CooperationData2> cooperationData2 = [
    CooperationData2(
      name: "张三",
      identity: "协作人",
      phone: "13333333333",
      joinTime: "2025-10-10 14:10:10",
    ),
    CooperationData2(
      name: "李四",
      identity: "创建人",
      phone: "13355555555",
      joinTime: "2025-10-10 14:10:10",
    ),
    CooperationData2(
      name: "王五",
      identity: "协作人",
      phone: "13356666666",
      joinTime: "2025-10-10 14:10:10",
    ),
  ];

  final List<String> processSelets = ["取证流程一", "取证流程二", "取证流程三"];
  String processSelect = "取证流程一";
  final List<String> processThirdSelects = ["证据", "流程信息"];
  String thirdSelect = "证据";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("案件详情"),
        actions: [TextButton(onPressed: () {}, child: Text("更多"))],
      ),
      body: CustomTabBar(
        tabBarViewPadding: EdgeInsets.zero,
        tabs: tabs,
        tabViews: [
          Padding(
            padding: EdgeInsets.all(Spacing.pageHorizontal),
            child: _buildBaseInfo(context),
          ),
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
              children: [
                TitleTile(title: "取证流程信息"),
                ...List.generate(baseInfoSteps.length, (index) {
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
                }),
              ],
            ),
          ),
      ],
    );
  }

  // 案件协作
  Widget _buildCaseCooperation(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(
              top: Spacing.pageHorizontal,
              left: Spacing.pageHorizontal,
              right: Spacing.pageHorizontal,
            ),
            children: [
              CustomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableChipGroup(
                      items: cooperationSelects,
                      initialValue: cooperationSelects[0],
                      onChanged: (String? value) {
                        setState(() {
                          if (value != null) cooperationSelect = value;
                        });
                      },
                    ),
                    if (cooperationSelect == cooperationSelects[0]) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("禁止协作人删除已存证证据"),
                          Transform.scale(
                            scale: 0.6,
                            child: Switch(
                              padding: EdgeInsets.zero,
                              value: _preventDeletion,
                              onChanged: (bool value) {
                                setState(() {
                                  _preventDeletion = value;
                                });
                              },
                              activeColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      ...cooperationData.map((item) {
                        return _buildOpperationCard(context, item);
                      }),
                    ] else
                      ...cooperationData2.map((item) {
                        return _buildOpperationCard2(item);
                      }),
                  ],
                ),
              ),
            ],
          ),
        ),
        BottomOperate(
          rate: 2,
          btns: [
            OperateButtonData("添加协作人", () => {print("保存")}),
          ],
        ),
      ],
    );
  }

  // 协作人卡片
  Widget _buildOpperationCard(BuildContext context, CooperationData data) {
    return CustomCard(
      // margin: EdgeInsets.only(bottom: Spacing.cardGap),
      color: Color(0xfff8fafb),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data.name),
              SizedBox(width: Spacing.xs),
              Text(
                data.identity,
                textAlign: TextAlign.end,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: Colors.grey),
              ),
              Spacer(),
              Text("已存证: ${data.storageQuantity}"),
            ],
          ),
          // const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("取证人 | 购买人"),
                  Text("设置", style: TextStyle(color: Colors.blue)),
                ],
              ),
              if (data.hasAuth)
                Row(
                  children: [
                    Text("申办授权"),
                    Transform.scale(
                      scale: 0.6,
                      child: Switch(
                        padding: EdgeInsets.zero,
                        value: data.authorization,
                        onChanged: (bool value) {
                          setState(() {
                            data.authorization = value;
                          });
                        },
                        activeColor: Colors.green,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          // const SizedBox(height: 8),
          // Text(evidenceCount, style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.grey[500])),
        ],
      ),
    );
  }

  // 写作人卡片2
  Widget _buildOpperationCard2(CooperationData2 data) {
    return CustomCard(
      color: Color(0xfff8fafb),
      child: Column(
        children: [
          Row(
            children: [
              Text(data.name),
              SizedBox(width: Spacing.xs),
              Text(data.identity),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(data.phone), Text("加入时间: ${data.joinTime}")],
          ),
        ],
      ),
    );
  }

  // 流程取证
  Widget _buildProcessEvidence(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: Spacing.verticalGapXS),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Spacing.cardPadding),
          color: Colors.white,
          child: SelectableChipGroup(
            items: processSelets,
            initialValue: processSelets[0],
            onChanged: (String? value) {
              setState(() {
                if (value != null) processSelect = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(Spacing.pageHorizontal),
          child: Column(
            children: [
              CustomCard(
                child: Column(
                  children: [
                    TitleTile(title: "取证方式"),
                    SizedBox(height: Spacing.listItemGap,),
                    Row(spacing: Spacing.xl, children: [
                      _buildCaseWay(),
                      _buildCaseWay(),
                    ],)
                  ],
                ),
              ),
              Container(
                height: 30.h,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Spacing.radiusMd),
                    bottomRight: Radius.circular(Spacing.radiusMd)
                  )
                ),
                child: Row(
                  children: 
                    processThirdSelects.map((item){
                      return Expanded(
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              thirdSelect = item;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            color: thirdSelect == item ? Color(0xFF002da6) : Color(0xFFdee1e7),
                            child: Text(item, style: TextStyle(color: thirdSelect == item ? Colors.white : null),),
                          ),
                        ),
                      );
                    }).toList(),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  // 取证方式
  Widget _buildCaseWay(){
    return Column(
      spacing: Spacing.verticalGapXS,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(
              Spacing.radiusSm,
            ),
          ),
          child: Icon(
            Icons.camera_alt,
            color: Colors.white,
            size: Spacing.iconXl,
          ),
        ),
        Text(
          "网页取证",
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // 案件出证
  Widget _buildCaseIssue(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Spacing.pageHorizontal),
      child: CaseListScreen(),
    );
  }
}

class BaseInfoData {
  final String title;
  final Widget? trailing;
  final bool border;
  BaseInfoData({required this.title, this.trailing, this.border = true});
}

class CooperationData {
  final String name;
  final String identity;
  final int storageQuantity;
  bool authorization;
  final bool hasAuth;
  CooperationData({
    required this.name,
    required this.identity,
    required this.storageQuantity,
    required this.authorization,
    this.hasAuth = true,
  });
}

class CooperationData2 {
  final String name;
  final String identity;
  final String phone;
  final String joinTime;
  CooperationData2({
    required this.name,
    required this.identity,
    required this.phone,
    required this.joinTime,
  });
}
