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

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _LoginWithPasswordPageState();
}

class _LoginWithPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneKey = GlobalKey<FormFieldState>();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 登录
  Future<void> _onLoginPressed() async {
    await Future.delayed(const Duration(seconds: 2));
    if (_formKey.currentState!.validate()) {
      final phone = _phoneController.text;
      final code = _codeController.text;
      final password = _passwordController.text;
      AppMessage.success("登陆中");
      print("$phone $code $password");
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
      appBar: AppBar(
        title: const Text("忘记密码"),
      ),
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

                          // 密码输入框
                          AuthTextField(
                            controller: _passwordController,
                            maxLength: 20,
                            hintText: '新密码',
                            validator: Validators.password,
                            obscureText: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9]*$')),
                            ],
                          ),

                          // 登录按钮
                          LoadingElevatedButton(
                            text: "确认修改密码",
                            onPressed: _onLoginPressed,
                          ),
                          SizedBox(height: Spacing.xl),

                          Spacer(),
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
}
