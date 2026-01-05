import 'package:flutter/material.dart';
import 'package:gzc_app/core/constants/app_images.dart';
import 'package:gzc_app/core/theme/colors.dart' show secondaryTextColor, textColor, surfaceColor;
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/custom_card.dart';
import 'package:gzc_app/core/widgets/custom_list_tile.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<InfoData> items = [
      InfoData(
        label: "头像",
        arrow: false,
        trailing: CircleAvatar(
          radius: Spacing.iconLg,
          backgroundColor: secondaryTextColor,
          child: CircleAvatar(
            radius: Spacing.iconXl,
            backgroundImage: Image.asset(AppImages.logo).image,
          ),
        ),
      ),
      InfoData(
        label: "密码",
        trailing: Text("******"),
        onTap: (){}
      ),
      InfoData(
        label: "手机号",
        trailing: Text("139***9999"),
        onTap: (){}
      ),
      InfoData(
        label: "邮箱",
        trailing: Text("去绑定",),
        onTap: (){}
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的资料'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          CustomCard(
            padding: EdgeInsets.zero,
            material: true,
            child: Column(
              children: items.map((item){
                return CustomListTile(
                  title: item.label,
                  showTrailingArrow: item.arrow,
                  showBottomBorder: true,
                  trailing: item.trailing,
                  onTap: item.onTap,
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class InfoData {
  final String label;
  final Widget? trailing;
  final bool arrow;
  final VoidCallback? onTap;
  InfoData({
    required this.label,
    this.trailing,
    this.arrow = true,
    this.onTap
  });
}