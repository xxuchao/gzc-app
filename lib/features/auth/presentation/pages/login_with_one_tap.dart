import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gzc_app/core/constants/app_base.dart';
import 'package:gzc_app/core/constants/routes.dart';
import 'package:gzc_app/core/utils/app_message.dart' show AppMessage;
import 'package:gzc_app/core/widgets/text_navigate_button.dart';
import 'package:gzc_app/features/auth/presentation/widgets/auth_btn.dart';
import 'package:gzc_app/features/auth/presentation/widgets/auto_logo.dart'
    show LoginLogo, LoginTitle;
import "package:gzc_app/core/theme/colors.dart" show primaryColor, surfaceColor;
import "package:gzc_app/core/theme/spacing.dart" show Spacing;
import '../widgets/protocol.dart' show ProtocolAgreement;

class LoginWithOneTapPage extends StatefulWidget {
  const LoginWithOneTapPage({super.key});

  @override
  State<LoginWithOneTapPage> createState() => _LoginWithPasswordPageState();
}

class _LoginWithPasswordPageState extends State<LoginWithOneTapPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneKey = GlobalKey<FormFieldState>();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  bool _agreed = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  // 登录
  Future<void> _onLoginPressed() async {
    await Future.delayed(const Duration(seconds: 2));
    if (_formKey.currentState!.validate()) {
      final phone = _phoneController.text;
      final code = _codeController.text;
      AppMessage.success("登陆中");
      print("$phone $code");
    }else {
      print("校验失败");
      throw Exception("校验失败");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor, // 深蓝色背景
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.pageHorizontal),
          child: Form(
            key: _formKey,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 30.w,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          LoginLogo(),
                          LoginTitle(),
                          SizedBox(height: Spacing.xxxl),

                          // 显示手机号（部分隐藏）
                          Text(
                            '173****7335',
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: surfaceColor, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: Spacing.md),
                          Text(
                            '由中国电信提供',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: surfaceColor),
                          ),

                          SizedBox(height: Spacing.xxxl),
                          // 登录按钮
                          LoadingElevatedButton(
                            text: "本机号码一键登录",
                            onPressed: _onLoginPressed,
                          ),
                          SizedBox(height: Spacing.xl),

                          // 其他登录方式
                          _buildOtherLoginWay(),

                          Spacer(),
                          // 协议勾选框
                          ProtocolAgreement(
                            value: _agreed,
                            onChanged: (v) => setState(() => _agreed = v),
                            userAgreementUrl: ApplicationBase.userAgreementUrl,
                            privacyPolicyUrl: ApplicationBase.privacyPolicyUrl,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // 其他登录方式
  Widget _buildOtherLoginWay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              TextNavigateButton(
                text: '验证码登录',
                route: AppRoutes.loginWithSms,
                textColor: surfaceColor,
                canPop: false,
              ),
              SizedBox(width: Spacing.xs),
              Text(
                "或",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: surfaceColor),
              ),
              SizedBox(width: Spacing.xs),
              TextNavigateButton(
                text: '账号密码登录',
                route: AppRoutes.loginWithPassword,
                textColor: surfaceColor,
                canPop: false,
              ),
            ],
          ),
        ),
        TextNavigateButton(
          text: '忘记密码？',
          route: AppRoutes.forgetPassword,
          textColor: surfaceColor,
        ),
      ],
    );
  }
}
