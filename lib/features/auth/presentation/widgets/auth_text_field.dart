// lib/features/auth/presentation/widgets/auth_text_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gzc_app/core/theme/colors.dart' show authButtonColor;
import 'package:gzc_app/core/theme/spacing.dart';

class AuthTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final int? maxLength; // 必填或可选？
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters; // 额外格式器（如只允许字母）
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  const AuthTextField({
    super.key,
    this.hintText,
    this.controller,
    this.maxLength, // 如果不传，则不限制
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.suffixIcon
  });

  @override
  Widget build(BuildContext context) {
    // 默认格式器：限制长度（如果 maxLength 有值）
    final formatters = <TextInputFormatter>[];
    if (maxLength != null) {
      formatters.add(LengthLimitingTextInputFormatter(maxLength!));
    }
    if (inputFormatters != null) {
      formatters.addAll(inputFormatters!);
    }

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: formatters.isEmpty ? null : formatters,
      decoration: InputDecoration(
        isDense: true,
        suffixIcon: suffixIcon,
        helperText: " ",
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: Spacing.lg, vertical: Spacing.lg),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          borderSide: const BorderSide(
            color: authButtonColor, // 黄色边框
            width: 2.0,
          ),
        ),
      ),
      validator: validator,
    );
  }
}