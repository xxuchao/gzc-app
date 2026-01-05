import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gzc_app/core/constants/routes.dart';
import 'package:gzc_app/core/theme/colors.dart' show lightGrey, secondaryTextColor;
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/bottom_operate.dart';
import 'package:gzc_app/core/widgets/checkradio.dart';
import 'package:gzc_app/core/widgets/verification_badge.dart';

class ApplicantManagementPage extends StatefulWidget {
  const ApplicantManagementPage({super.key});

  @override
  State<ApplicantManagementPage> createState() => _ApplicantManagementPageState();
}

class _ApplicantManagementPageState extends State<ApplicantManagementPage> {
  int defaultAddressIndex = -1;
  // 申请人列表数据
  List<Applicant> applicants = [
    Applicant(
      name: '彭于晏',
      isVerified: true,
      isDefault: true,
      canViewDetails: true,
    ),
    Applicant(
      name: '张家辉',
      isVerified: true,
      isDefault: false,
      canViewDetails: true,
    ),
    Applicant(
      name: '张家辉',
      isVerified: false,
      isDefault: false,
      canViewDetails: false,
    ),
    Applicant(
      name: '彭于晏',
      isVerified: true,
      isDefault: true,
      canViewDetails: true,
    ),
    Applicant(
      name: '张家辉',
      isVerified: true,
      isDefault: false,
      canViewDetails: true,
    ),
    Applicant(
      name: '张家辉',
      isVerified: false,
      isDefault: false,
      canViewDetails: false,
    ),
    Applicant(
      name: '彭于晏',
      isVerified: true,
      isDefault: true,
      canViewDetails: true,
    ),
    Applicant(
      name: '张家辉',
      isVerified: true,
      isDefault: false,
      canViewDetails: true,
    ),
    Applicant(
      name: '张家辉',
      isVerified: false,
      isDefault: false,
      canViewDetails: false,
    ),
  ];

  void setDefaultAddress(int index){
    setState(() {
      defaultAddressIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text('申请人管理',),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: Spacing.pageTop, left: Spacing.pageHorizontal, right: Spacing.pageHorizontal),
              itemCount: applicants.length,
              itemBuilder: (context, index) {
                return _buildApplicantCard(context, applicants[index], index);
              },
            ),
          ),

          BottomOperate(
            rate: 2,
            btns: [
              OperateButtonData(
                "申请添加人",
                () => { print("申请添加人")}
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildApplicantCard(BuildContext context, Applicant applicant, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: Spacing.pageHorizontal),
      padding: EdgeInsets.all(Spacing.pageHorizontal),
      decoration: BoxDecoration(
        color: applicant.isVerified ? Theme.of(context).colorScheme.surface : lightGrey,
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: Spacing.radiusMd,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 姓名和认证状态
          Row(
            children: [
              Text(
                applicant.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(width: Spacing.md),
              VerificationBadge(isVerified: applicant.isVerified),
            ],
          ),
          SizedBox(height: Spacing.listItemGap),
          
          // 设为默认和查看详情
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleCheckRadio(
                label: "设为默认",
                isSelected: defaultAddressIndex == index,
                onTap: (){
                  setDefaultAddress(index);
                },
              ),
              
              // 查看详情按钮
              if (applicant.canViewDetails)
                GestureDetector(
                  onTap: () {
                    // 跳转路由
                    context.push(AppRoutes.applicantDetail);
                  },
                  child: Row(
                    children: [
                      Text(
                        '查看详情',
                        style: Theme.of(context).textTheme.bodyMedium // ?.copyWith(color: secondaryTextColor, height: 1.4),
                      ),
                      SizedBox(width: Spacing.xs),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: Spacing.iconXS,
                        color: secondaryTextColor,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

}

// 申请人数据模型
class Applicant {
  String name;
  bool isVerified;
  bool isDefault;
  bool canViewDetails;

  Applicant({
    required this.name,
    required this.isVerified,
    required this.isDefault,
    required this.canViewDetails,
  });
}