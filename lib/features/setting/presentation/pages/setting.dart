import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gzc_app/core/widgets/custom_list_tile.dart';

class SystemSettingsPage extends StatelessWidget {
  const SystemSettingsPage({super.key});

  void handleItemTap(){}

  @override
  Widget build(BuildContext context) {
    final List<SettingData> items = [
      SettingData(title: "隐私保护协议",),
      SettingData(title: "用户服务协议",),
      SettingData(title: "关于我们",),
      SettingData(title: "清除缓存", text: "9.84MB", arrow: false),
      SettingData(title: "证据还原",),
      SettingData(title: "已存证证据清理",),
      SettingData(title: "快捷键设置",),
      SettingData(title: "后台取证权限设置",),
      SettingData(title: "注销账号",),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('系统设置'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
      ),
      body: Column(
        children: [
          // 设置项列表
          Expanded(
            child: ListView(
              children: [
                Ink(
                  color: Colors.white,
                  child: Column(
                    children: items.map((item){
                      return CustomListTile(
                        title: item.title,
                        trailing: item.text == null ? null : Text(item.text!),
                        showTrailingArrow: item.arrow,
                        showBottomBorder: item.border,
                        onTap: handleItemTap,
                      );
                    }).toList(),
                  ),
                )
              ],
              // children: [
              //   // 隐私保护协议
              //   _buildListItem('隐私保护协议'),
              //   const Divider(height: 1),
              //   // 用户服务协议
              //   _buildListItem('用户服务协议'),
              //   const Divider(height: 1),
              //   // 关于我们
              //   _buildListItem('关于我们'),
              //   const Divider(height: 1),
              //   // 清除缓存
              //   _buildListItem('清除缓存', trailingText: '9.84MB'),
              //   const Divider(height: 1),
              //   // 证据还原
              //   _buildListItem('证据还原'),
              //   const Divider(height: 1),
              //   // 已存证证据清理
              //   _buildListItem('已存证证据清理'),
              //   const Divider(height: 1),
              //   // 快捷键设置
              //   _buildListItem('快捷键设置'),
              //   const Divider(height: 1),
              //   // 后台取证权限设置
              //   _buildListItem('后台取证权限设置'),
              //   const Divider(height: 1),
              //   // 注销账号
              //   _buildListItem('注销账号'),
              //   const Divider(height: 1),
              // ],
            ),
          ),
          // 退出登录按钮
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // 退出登录逻辑
              },
              style: ElevatedButton.styleFrom(
                // primary: Colors.red, // 按钮背景颜色
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                minimumSize: const Size(double.infinity, 48), // 按钮宽度填充父容器
              ),
              child: const Text(
                '退出登录',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingData {
  final String title;
  final String? text;
  final bool border;
  final bool arrow;
  SettingData({
    required this.title,
    this.text,
    this.border = true,
    this.arrow = true
  });
}