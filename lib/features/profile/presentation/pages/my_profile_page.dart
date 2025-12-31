import 'package:flutter/material.dart';
import 'package:gzc_app/core/constants/app_images.dart';
import 'package:gzc_app/core/theme/colors.dart' show secondaryTextColor, textColor, surfaceColor;
import 'package:gzc_app/core/theme/spacing.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的资料'),
      ),
      body: Column(
        children: [
          // 头像项
          _buildProfileItem(
            context,
            label: '头像',
            trailing: CircleAvatar(
              radius: Spacing.iconLg,
              backgroundColor: secondaryTextColor,
              child: CircleAvatar(
                radius: Spacing.iconXl,
                backgroundImage: Image.asset(AppImages.logo).image,
              ),
            ),
            arrow: false,
            onTap: () {
              // 处理头像点击
              print('点击头像');
            },
          ),
          
          // 密码项
          _buildProfileItem(
            context,
            label: '密码',
            value: '******',
            onTap: () {
              // 处理密码修改
              print('修改密码');
            },
          ),
          
          // 手机号项
          _buildProfileItem(
            context,
            label: '手机号',
            value: '130****1959',
            onTap: () {
              // 处理手机号修改
              print('修改手机号');
            },
          ),
          
          // 邮箱项
          _buildProfileItem(
            context,
            label: '邮箱',
            value: '去绑定',
            valueColor: secondaryTextColor,
            onTap: () {
              // 处理邮箱绑定
              print('绑定邮箱');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(
    BuildContext context, {
    required String label,
    String? value,
    Widget? trailing,
    Color? valueColor,
    bool arrow = true,
    VoidCallback? onTap,
  }) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 1),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: Spacing.pageHorizontal, vertical: 0),
        title: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (value != null)
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: valueColor ?? textColor),
              ),
            if (trailing != null) trailing,
            if (value != null || trailing != null) const SizedBox(width: 8),
            if (arrow) Icon(
              Icons.arrow_forward_ios,
              size: Spacing.iconSm,
              color: secondaryTextColor,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}