// #抽象接口


import 'package:gzc_app/features/auth/domain/entities/user.dart';

abstract class AuthRespository {
  Future<User> login(String phone, String password);
  void logout();
}