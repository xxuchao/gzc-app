import 'package:flutter/material.dart';
import 'package:gzc_app/core/constants/app_images.dart';
import 'package:gzc_app/core/constants/routes.dart';
import 'package:gzc_app/core/router/app_router.dart';
import 'package:gzc_app/core/theme/colors.dart' show primaryColor, surfaceColor, secondaryTextColor, tagSuccessColor, tagWarningColor;
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:share_plus/share_plus.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 头部信息区域
        _buildInfo(context),
    
        // 存证币余额
        _buildBalance(context),
        
        SizedBox(height: Spacing.lg),

        // 功能列表
        _buildFunctionList(context),
      ],
    );
  }

  // 用户信息区域
  Widget _buildInfo(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(vertical: Spacing.lg, horizontal: Spacing.pageHorizontal),
      color: surfaceColor,
      child: Row(
        children: [
          CircleAvatar(
            radius: Spacing.iconXl,
            backgroundImage: Image.asset(AppImages.logo).image, // TODO: 替换为真实头像URL
          ),
          SizedBox(width: Spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '真实姓名（机构名称）',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: Spacing.xs),
                Text(
                  '18958266666',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: secondaryTextColor),
                ),
                SizedBox(height: Spacing.xs),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: tagSuccessColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '已实名认证',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: surfaceColor),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: tagWarningColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '去实名认证',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: surfaceColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 存证币余额
  Widget _buildBalance(BuildContext context){
    // 存证币余额
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Spacing.pageHorizontal),
      padding: EdgeInsets.all(Spacing.pageHorizontal),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Spacing.radiusLg),
          bottomRight: Radius.circular(Spacing.radiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '可用存证币',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: surfaceColor),
              ),
              SizedBox(height: Spacing.xs),
              Text(
                '3610',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: surfaceColor),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: surfaceColor,
              foregroundColor: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.radiusXXL)),
              padding: EdgeInsets.symmetric(horizontal: Spacing.xxxl),
            ),
            child: const Text('充值'),
          ),
        ],
      ),
    );
  }

  // 功能列表
  Widget _buildFunctionList(BuildContext context){
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(height: 0, thickness: 0.5,),
        shrinkWrap: true,
        itemCount: 8,
        itemBuilder: (context, index) {
          final List<MenuItem> items = [
            MenuItem(title: '我的资料', route: AppRoutes.profile, icon: Icons.person, diver: true),
            MenuItem(title: '申请人管理', route: AppRoutes.applicantManagement, icon: Icons.group, diver: true),
            MenuItem(title: '地址管理', route: AppRoutes.addressManagement, icon: Icons.location_on, diver: true),
            MenuItem(title: '发票管理', route: AppRoutes.invoiceManagement, icon: Icons.receipt, diver: true),
            MenuItem(title: '收费标准', route: AppRoutes.feeStandard, icon: Icons.attach_money, diver: true),
            MenuItem(title: '我的推荐码', route: AppRoutes.referralCode, icon: Icons.developer_board_outlined, diver: true),
            MenuItem(title: '分享APP', route: "share", icon: Icons.share, diver: true),
            MenuItem(title: '系统设置', route: AppRoutes.settings, icon: Icons.settings, diver: true),
          ];
          return Container(
            color: surfaceColor,
            child: ListTile(
              horizontalTitleGap: Spacing.xs,
              contentPadding: EdgeInsets.symmetric(horizontal: Spacing.pageHorizontal),
              leading: Icon(items[index].icon, color: primaryColor, size: Spacing.iconMd),
              title: Text(
                items[index].title,
                style: Theme.of(context).textTheme.bodyMedium
              ),
              // trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                if (items[index].route == "share") {
                  // TODO: 实现分享功能
                  SharePlus.instance.share(
                    ShareParams(text: 'check out my website https://example.com')
                  );
                } else {
                  // context.push(items[index].route);
                  AppRouter.pushNamed(items[index].route);
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class MenuItem {
  final String title;
  final String route;
  final IconData icon;
  final bool diver;

  const MenuItem({required this.title, required this.route, required this.icon, required this.diver});
}