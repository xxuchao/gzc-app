import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SystemSettingsPage extends StatelessWidget {
  const SystemSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                // 隐私保护协议
                _buildListItem('隐私保护协议'),
                const Divider(height: 1),
                // 用户服务协议
                _buildListItem('用户服务协议'),
                const Divider(height: 1),
                // 关于我们
                _buildListItem('关于我们'),
                const Divider(height: 1),
                // 清除缓存
                _buildListItem('清除缓存', trailingText: '9.84MB'),
                const Divider(height: 1),
                // 证据还原
                _buildListItem('证据还原'),
                const Divider(height: 1),
                // 已存证证据清理
                _buildListItem('已存证证据清理'),
                const Divider(height: 1),
                // 快捷键设置
                _buildListItem('快捷键设置'),
                const Divider(height: 1),
                // 后台取证权限设置
                _buildListItem('后台取证权限设置'),
                const Divider(height: 1),
                // 注销账号
                _buildListItem('注销账号'),
                const Divider(height: 1),
              ],
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

  Widget _buildListItem(String title, {String? trailingText}) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
      trailing: trailingText != null
          ? Text(
              trailingText,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            )
          : const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.black54,
            ),
      onTap: () {
        // 点击事件逻辑
      },
    );
  }
}