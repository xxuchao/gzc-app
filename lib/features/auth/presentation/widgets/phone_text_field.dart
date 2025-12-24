// lib/features/auth/presentation/widgets/phone_text_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gzc_app/core/theme/colors.dart' show authButtonColor;
import 'package:gzc_app/core/theme/spacing.dart';

class PhoneTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? hintText;
  final GlobalKey<FormFieldState>? formKey;

  const PhoneTextField({
    super.key,
    required this.controller,
    this.validator,
    this.hintText = '手机号',
    this.formKey
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: formKey,
      controller: controller,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
      ],
      decoration: InputDecoration(
        isDense: true,
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