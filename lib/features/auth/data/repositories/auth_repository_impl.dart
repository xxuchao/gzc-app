// 实现 domain 的 repository 接口
import 'package:gzc_app/core/local_storage/storage_service.dart';
import 'package:gzc_app/features/auth/data/datasources/auth_remote.dart';
import 'package:gzc_app/features/auth/domain/entities/user.dart';
import 'package:gzc_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRespository {
  final AuthRemoteDataSource remoteDataSource;
  final LocalStorageService localStorage; // 👈 注入抽象
  final SecureStorageService secureStorage;   // ← 敏感数据

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
    required this.secureStorage
  });

  @override
  Future<User> loginWithPassword({required String phone, required String password}) async {
    final user = await remoteDataSource.loginWithPassword(phone, password);
    return user.toEntity();
  }
  
  @override
  Future<User> loginWithOneTap({required String phoneNumber, required String accessToken}) {
    // TODO: implement loginWithOneTap
    throw UnimplementedError();
  }
  
  @override
  Future<User> loginWithSmsCode({required String phone, required String code}) async {
    final user = await remoteDataSource.loginWithSmsCode(phone, code);

    // TODO: 处理token信息

    return user.toEntity();
  }


  @override
  void logout() {
    // TODO: implement logout
  }
}