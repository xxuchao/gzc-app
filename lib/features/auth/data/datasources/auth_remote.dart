// # Dio 调用 API

import 'package:gzc_app/core/network/net_client.dart';
import 'package:gzc_app/features/auth/domain/entities/user.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
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
}