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

    final token = user.orgName;

    await localStorage.setString('auth_token', token);
    // await localStorage.setString('user', jsonEncode(user.toJson())); // UserModel 需要 toJson()

    return user;
  }
  
  @override
  Future<User> loginWithOneTap({required String phoneNumber, required String accessToken}) {
    // TODO: implement loginWithOneTap
    throw UnimplementedError();
  }
  
  @override
  Future<User> loginWithSmsCode({required String phone, required String code}) {
    // TODO: implement loginWithSmsCode
    throw UnimplementedError();
  }


  @override
  void logout() {
    // TODO: implement logout
  }

// 👇 提取公共存储逻辑
  Future<void> saveAuthData(User user) async {
    // final token = user.orgName; // 或从其他字段获取
    // await secureStorage.write(StorageKeys.authToken, token);
    // await localStorage.setString(StorageKeys.user, jsonEncode(user.toJson()));
  }
}