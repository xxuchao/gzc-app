class Validators {
  // 手机号校验
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入手机号';
    }
    if (value.length != 11) {
      return '手机号应为11位';
    }
    final phoneRegex = RegExp(r'^1[3-9]\d{9}$');
    if (!phoneRegex.hasMatch(value)) {
      return '手机号格式不正确';
    }
    return null;
  }

  // 验证码校验（支持自定义长度）
  static String? code(String? value, {int length = 6}) {
    if (value == null || value.isEmpty) {
      return '请输入验证码';
    }
    if (value.length != length) {
      return '验证码应为$length位';
    }
    // 可选：只允许数字
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return '验证码只能包含数字';
    }
    return null;
  }

  // 密码校验（示例：6-20位）
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入密码';
    }
    if (value.length < 6) {
      return '密码至少6位';
    }
    if (value.length > 20) {
      return '密码最多20位';
    }
    return null;
  }

  // 必填校验
  static String? required(String? value) {
    return (value?.trim().isEmpty ?? true) ? '此项必填' : null;
  }

  // 用户名（字母/数字/下划线，3-20位）
  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入用户名';
    }
    if (value.length < 3) {
      return '用户名至少3位';
    }
    if (value.length > 20) {
      return '用户名最多20位';
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return '只能包含字母、数字和下划线';
    }
    return null;
  }
}