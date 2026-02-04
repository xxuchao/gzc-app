import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gzc_app/core/constants/app_base.dart';
import 'package:gzc_app/core/constants/routes.dart';
import 'package:gzc_app/core/models/webview_args.dart';
import 'package:gzc_app/core/router/app_router.dart';
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/utils/app_message.dart';
import 'package:gzc_app/core/widgets/custom_list_tile.dart';
// import 'package:gzc_app/core/widgets/functional_dialog.dart';
import 'package:gzc_app/core/widgets/operate_button.dart';
// import 'package:gzc_app/core/widgets/show_confirm_dialog.dart';
// import 'package:gzc_app/features/webview/webview.utils.dart';

class SystemSettingsPage extends StatelessWidget {
  const SystemSettingsPage({super.key});

  void handleItemTap(BuildContext context, int id){
    switch(id){
      case 1:
        // openWebView(context, title: '隐私政策', url: ApplicationBase.userAgreementUrl);
        AppRouter.pushNamed(AppRoutes.webview, arguments: WebViewArgs(title: "隐私政策", url: ApplicationBase.privacyPolicyUrl));
        return;
      case 2:
        // openWebView(context, title: '用户协议', url: ApplicationBase.userAgreementUrl);
        AppRouter.pushNamed(AppRoutes.webview, arguments: WebViewArgs(title: "隐私政策", url: ApplicationBase.privacyPolicyUrl));
        return;
      default:
        AppMessage.info("未开放");
        // showCustomStyledDialog(context: context, title: "提示");
        // showFunctionalDialog(context: context, title: Text("提示"), content: Text("123"), primaryAction: DialogAction(
        //   text: "xx",
        //   onPressed: () => print("123"),
        // ), secondaryAction: DialogAction(text: "aa", onPressed: () => print("aaa"),));
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<SettingData> items = [
      SettingData(id: 1, title: "隐私保护协议",),
      SettingData(id: 2, title: "用户服务协议",),
      SettingData(id: 3, title: "关于我们",),
      SettingData(id: 4, title: "清除缓存", text: "9.84MB", arrow: false),
      SettingData(id: 5, title: "证据还原",),
      SettingData(id: 6, title: "已存证证据清理",),
      SettingData(id: 7, title: "快捷键设置",),
      SettingData(id: 8, title: "后台取证权限设置",),
      SettingData(id: 9, title: "注销账号",),
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
      body: SafeArea(
        child: Column(
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
                          onTap: () => handleItemTap(context, item.id),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
            // 退出登录按钮
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.pageHorizontal, vertical: Spacing.buttonPaddingV),
              child: OperateButton(
                width: double.maxFinite,
                height: Spacing.buttonHeight,
                "退出登录",
                () => AppMessage.info("未开放")
              )
            ),
          ],
        ),
      ),
    );
  }
}

class SettingData {
  final int id;
  final String title;
  final String? text;
  final bool border;
  final bool arrow;
  SettingData({
    required this.id,
    required this.title,
    this.text,
    this.border = true,
    this.arrow = true
  });
}