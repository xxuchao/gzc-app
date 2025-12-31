// # Dio 调用 API

import 'package:gzc_app/core/network/net_client.dart';
import 'package:gzc_app/features/auth/domain/entities/user.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<User> loginWithPassword(String phone, String password);
  Future<User> loginWithSmsCode(String phone, String code);
  Future<User> loginWithOneTap(String phoneNumber, String accessToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final NetClient _dioClient = NetClient();

  Future<User> login(String username, String password) async {
    try { 
      final response = await _dioClient.post('/auth/login', data: {
        'username': username,
        'password': password,
      });
      if (response.isSuccess && response.data != null) {
        final UserModel userDTO = UserModel.fromJson(response.data);
        return userDTO.toEntity();
      }
      throw Exception("登录失败");
    } catch (e) {
      throw Exception('登录失败: ${e.toString()}');
    }
  }
  
  @override
  Future<User> loginWithOneTap(String phoneNumber, String accessToken) {
    // TODO: implement loginWithOneTap
    throw UnimplementedError();
  }
  
  @override
  Future<User> loginWithPassword(String phone, String password) {
    // TODO: implement loginWithPassword
    throw UnimplementedError();
  }
  
  @override
  Future<User> loginWithSmsCode(String phone, String code) {
    // TODO: implement loginWithSmsCode
    throw UnimplementedError();
  }
}