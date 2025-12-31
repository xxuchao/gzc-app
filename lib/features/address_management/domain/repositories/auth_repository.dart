// #抽象接口

import 'package:gzc_app/features/auth/domain/entities/user.dart';

abstract class AuthRespository {
  Future<User> loginWithPassword({
    required String phone,
    required String password
  });
  // 验证码登录
  Future<User> loginWithSmsCode({
    required String phone,
    required String code,
  });
  // 本机号码一键登录
  Future<User> loginWithOneTap({
    required String phoneNumber,
    required String accessToken,
  });
  void logout();
}