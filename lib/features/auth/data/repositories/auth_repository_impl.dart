// 实现 domain 的 repository 接口
import 'package:gzc_app/features/auth/data/datasources/auth_remote.dart';
import 'package:gzc_app/features/auth/domain/entities/user.dart';
import 'package:gzc_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRespository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> login(String phone, String password) async {
    return remoteDataSource.login(phone, password);
  }

  @override
  void logout() {
    // TODO: implement logout
  }
}