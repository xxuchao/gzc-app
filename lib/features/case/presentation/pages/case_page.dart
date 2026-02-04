import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/custom_tabbar.dart';
import 'package:gzc_app/core/widgets/drop_down.dart';
import 'package:gzc_app/features/case/presentation/widgets/case_info.dart';

class CasePage extends StatefulWidget {
  const CasePage({super.key});

  @override
  State<CasePage> createState() => _CasePageState();
}

class _CasePageState extends State<CasePage> {
  final List<Tab> caseTabs = [Tab(text: "单个案件"), Tab(text: "项目案件")];
  final List<Tab> classTabs = [
    Tab(text: "未申请出证"),
    Tab(text: "已申请出证"),
    Tab(text: "已出证案件"),
    Tab(text: "已终止出证"),
  ];

  final Map<String, String> _options = {
    'option1': '首页',
    'option2': '消息',
    'option3': '个人中心',
    'option4': '设置',
    'option5': '设置',
    'option6': '设置',
    'option7': '设置',
    'option8': '设置',
    'option9': '设置',
    'option10': '设置',
    'option11': '设置',
    'option12': '设置',
  };

  @override
  Widget build(BuildContext context) {
    return CustomTabBar(
      scroll: const NeverScrollableScrollPhysics(),
      tabBarViewPadding: EdgeInsets.zero,
      tabs: caseTabs,
      tabViews: [_buildSingleCase(context), _buildProjectCase(context)],
    );
  }

  Widget _buildSingleCase(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.cardPadding,
            vertical: Spacing.xs,
          ),
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            children: [
              Container(
                height: 42.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300], // 设置背景为浅灰色
                  borderRadius: BorderRadius.circular(Spacing.radiusXXL), // 圆角
                ),
                child: TextField(
                  style: Theme.of(context).textTheme.bodyMedium, // 输入文字颜色设为黑色以保证可读性
                  cursorColor: Colors.black, // 光标颜色
                  decoration: InputDecoration(
                    hintText: '请输入关键词',
                    hintStyle: TextStyle(color: Colors.grey[600]), // 提示文字颜色稍暗一些
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: Spacing.cardPadding,
                      vertical: 0,
                    ),
                    border: InputBorder.none, // 去掉默认边框
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey[600], // 搜索图标颜色
                        size: 20,
                      ),
                    ),
                  ),
                  onSubmitted: (value) {
                    // 执行搜索逻辑
                  },
                ),
              ),
              SizedBox(height: Spacing.xs,),
              Row(
                spacing: Spacing.xs,
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomDropDown(
                      boxRadius: Spacing.radiusXXL,
                      boxColor: Color(0xFFe0e0e0),
                      options: _options,
                      hintText: "案件类型(一二级)",
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: CustomDropDown(
                      boxRadius: Spacing.radiusXXL,
                      boxColor: Color(0xFFe0e0e0),
                      options: _options,
                      hintText: "案件创建人",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: CustomTabBar(
            // tabBarViewPadding: EdgeInsets.zero,
            tabs: classTabs,
            tabViews: [
              CaseListScreen(), Container(), Container(), Container()
            ],
          ),
        ),
      ],
    );
  }

  // 项目案件
  Widget _buildProjectCase(BuildContext context) {
    return Container();
  }
}
