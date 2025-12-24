// lib/core/widgets/loading_elevated_button.dart
import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/colors.dart' show authButtonColor, textColor;

/// 通用的带加载状态的按钮（适用于登录、提交等场景）
class LoadingElevatedButton extends StatefulWidget {
  /// 按钮被点击时执行的异步操作（如登录、注册）
  final Future<void> Function() onPressed;

  /// 默认按钮文本
  final String text;

  /// 加载中文案（可选，留空则只显示 loading）
  final String? loadingText;

  /// 按钮背景色
  final Color backgroundColor;

  /// 文字颜色
  final Color txtColor;

  /// 按钮高度
  final double height;

  /// 圆角
  final double borderRadius;

  /// 文字间距
  final double textSpacing;

  /// 失败时的回调（用于显示错误提示等）
  final void Function(Object error)? onFailure;

  const LoadingElevatedButton({
    super.key,
    required this.onPressed,
    this.text = '提交',
    this.loadingText,
    this.backgroundColor = authButtonColor,
    this.txtColor = textColor,
    this.height = 50,
    this.borderRadius = 25,
    this.onFailure,
    this.textSpacing = 1
  });

  @override
  State<LoadingElevatedButton> createState() => _LoadingElevatedButtonState();
}

class _LoadingElevatedButtonState extends State<LoadingElevatedButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: TextButton(
        onPressed: _isLoading
          ? null
          : () async {
            setState(() => _isLoading = true);
            try {
              await widget.onPressed();
              // 成功：什么都不做（由业务跳转页面）
            } catch (error) {
              widget.onFailure?.call(error);
            } finally {
              if (mounted) {
                setState(() => _isLoading = false);
              }
            }
          },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.center,
        ),
        child: _buildChild(context),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    if (_isLoading) {
      if (widget.loadingText != null) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.loadingText!,
              style: TextStyle(
                color: widget.txtColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        );
      } else {
        return SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        );
      }
    } else {
      return Text(
        widget.text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(letterSpacing: widget.textSpacing, color: widget.txtColor),
      );
    }
  }
}
