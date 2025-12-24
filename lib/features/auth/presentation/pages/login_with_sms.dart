import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gzc_app/core/constants/app_base.dart';
import 'package:gzc_app/core/constants/routes.dart';
import 'package:gzc_app/core/utils/app_message.dart' show AppMessage;
import 'package:gzc_app/core/widgets/text_navigate_button.dart';
import 'package:gzc_app/features/auth/presentation/widgets/auth_btn.dart';
import 'package:gzc_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:gzc_app/features/auth/presentation/widgets/auto_logo.dart'
    show LoginLogo, LoginTitle;
import "package:gzc_app/core/theme/colors.dart" show primaryColor, surfaceColor;
import "package:gzc_app/core/theme/spacing.dart" show Spacing;
import 'package:gzc_app/core/utils/validators.dart' show Validators;
import 'package:gzc_app/features/auth/presentation/widgets/countdown_code_btn.dart';

import '../widgets/phone_text_field.dart' show PhoneTextField;
import '../widgets/protocol.dart' show ProtocolAgreement;

class LoginWithPasswordPage extends StatefulWidget {
  const LoginWithPasswordPage({super.key});

  @override
  State<LoginWithPasswordPage> createState() => _LoginWithPasswordPageState();
}

class _LoginWithPasswordPageState extends State<LoginWithPasswordPage> {
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
    if (_formKey.currentState!.validate()) {
      final phone = _phoneController.text;
      final code = _codeController.text;
      print("$phone $code");
    }else {
      print("校验失败");
      throw Exception("校验失败");
    }
  }

  // 获取验证码
  Future<void> _onCodePresssed() async {
    await Future.delayed(const Duration(seconds: 2));
    if (_phoneKey.currentState!.validate()) {
      AppMessage.success("验证码已发送");
    } else {
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

                          // 手机号输入框
                          PhoneTextField(
                            formKey: _phoneKey,
                            controller: _phoneController,
                            validator: Validators.phone,
                          ),

                          // 验证码输入框 + 获取验证码按钮
                          _buildCode(),

                          // 登录按钮
                          LoadingElevatedButton(
                            text: "登录",
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

  // 验证码输入框 + 获取验证码按钮
  Widget _buildCode() {
    return AuthTextField(
      controller: _codeController,
      maxLength: 6,
      hintText: '验证码',
      validator: Validators.code,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9]*$')),
      ],
      suffixIcon: Padding(
        padding: EdgeInsets.all(Spacing.xs),
        child: CountdownCodeButton(onPressed: _onCodePresssed),
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
                text: '手机号一键登录',
                route: AppRoutes.home,
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
                route: AppRoutes.home,
                textColor: surfaceColor,
                canPop: false,
              ),
            ],
          ),
        ),
        TextNavigateButton(
          text: '忘记密码？',
          route: AppRoutes.home,
          textColor: surfaceColor,
        ),
      ],
    );
  }
}
