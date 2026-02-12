// # Dio 调用 API

import 'package:gzc_app/core/network/net_client.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginWithPassword(String phone, String password);
  Future<UserModel> loginWithSmsCode(String phone, String code);
  Future<UserModel> loginWithOneTap(String phoneNumber, String accessToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final NetClient _dioClient = NetClient();

  Future<UserModel> login(String username, String password) async {
    try { 
      final response = await _dioClient.post('/auth/login', data: {
        'username': username,
        'password': password,
      });
      if (response.isSuccess && response.data != null) {
        final UserModel userDTO = UserModel.fromJson(response.data);
        return userDTO;
      }
      throw Exception("登录失败");
    } catch (e) {
      throw Exception('登录失败: ${e.toString()}');
    }
  }
  
  @override
  Future<UserModel> loginWithOneTap(String phoneNumber, String accessToken) {
    // TODO: implement loginWithOneTap
    throw UnimplementedError();
  }
  
  @override
  Future<UserModel> loginWithPassword(String phone, String password) {
    // TODO: implement loginWithPassword
    throw UnimplementedError();
  }
  
  @override
  Future<UserModel> loginWithSmsCode(String phone, String code) {
    // TODO: implement loginWithSmsCode
    throw UnimplementedError();
  }
}