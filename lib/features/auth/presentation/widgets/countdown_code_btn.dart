import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gzc_app/core/theme/colors.dart' show authButtonColor, textColor, surfaceColor;
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/utils/devices.dart';

/// 获取验证码倒计时按钮
class CountdownCodeButton extends StatefulWidget {
  /// 按钮被点击时的回调（应在其中调用发送验证码接口）
  final Future<void> Function() onPressed;

  /// 倒计时时长（秒），默认 60
  final int duration;

  /// 默认状态下的按钮文本
  final String normalText;

  /// 倒计时期间的文本模板，例如：'{seconds} 秒后重试'
  final String countdownTextTemplate;

  /// 按钮样式（可选）
  final ButtonStyle? style;

  /// 倒计时期间是否禁用按钮（默认 true）
  final bool disableDuringCountdown;

  /// 当发送验证码失败时调用此回调，按钮将立即恢复可点击状态
  final VoidCallback? onFailure;

  const CountdownCodeButton({
    super.key,
    required this.onPressed,
    this.duration = 60,
    this.normalText = '获取验证码',
    this.countdownTextTemplate = '{seconds} 秒后重试',
    this.style,
    this.disableDuringCountdown = true,
    this.onFailure,
  });

  @override
  State<CountdownCodeButton> createState() => _CountdownCodeButtonState();
}

class _CountdownCodeButtonState extends State<CountdownCodeButton> {
  late int _remainingSeconds;
  Timer? _timer;
  bool _isLoading = false;
  bool _isCounting = false;
  final double widgetWidth = DeviceUtils.screenWidth * 0.33;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // 开始倒计时
  void _startCountdown() {
    if (_isCounting) return;

    setState(() {
      _remainingSeconds = widget.duration;
      _isCounting = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 0) {
        timer.cancel();
        if (mounted) {
          setState(() => _isCounting = false);
        }
      } else {
        if (mounted) {
          setState(() => _remainingSeconds--);
        }
      }
    });
  }

  /// 外部可调用：手动恢复按钮（如网络失败时）
  void reset() {
    _timer?.cancel();
    if (mounted) {
      setState((){
        _isCounting = false;
        _isLoading = false;
      });
    }
  }

  /// 暴露给父组件的方法（通过 GlobalKey）
  CountdownCodeButtonController get controller =>
      CountdownCodeButtonController._(reset);

  @override
  Widget build(BuildContext context) {
    final isDisabled = (_isLoading && widget.disableDuringCountdown) || (_isCounting && widget.disableDuringCountdown);

    return SizedBox(
      width: widgetWidth,
      child: ElevatedButton(
        onPressed: isDisabled
            ? null
            : () async {
                widget.onPressed();
                // setState(() => _isLoading = true);
                // try {
                //   await widget.onPressed();
                //   // 成功后启动倒计时
                //   _startCountdown();
                //   setState(() => _isLoading = false);
                // } catch (e) {
                //   // 失败：立即恢复按钮
                //   widget.onFailure?.call();
                //   reset();
                // }
              },
        style:
            widget.style ??
            ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((
                Set<WidgetState> states,
              ) {
                return authButtonColor; // 启用色
              }),
              foregroundColor: WidgetStateProperty.resolveWith((
                Set<WidgetState> states,
              ) {
                return textColor;
              }),
              padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(
                  horizontal: Spacing.lg,
                  vertical: Spacing.md,
                ),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Spacing.radiusMd),
                ),
              ),
            ),
        child: 
          _isLoading ? SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(
              color: surfaceColor,
              strokeWidth: 2,
            ),
          ) : Text(
          _isCounting
              ? widget.countdownTextTemplate.replaceAll(
                  '{seconds}',
                  _remainingSeconds.toString(),
                )
              : widget.normalText,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

/// 控制器：用于外部手动重置按钮状态（如登录成功后重置验证码按钮）
class CountdownCodeButtonController {
  final VoidCallback _reset;

  CountdownCodeButtonController._(this._reset);

  /// 手动重置倒计时状态，使按钮恢复可点击
  void reset() => _reset();
}
