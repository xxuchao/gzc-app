
import "../repositories/auth_repository.dart";
import "../entities/user.dart";

class LoginSmsUsecase {
  final AuthRespository repository;

  LoginSmsUsecase({required this.repository});

  Future<User> call(String phone, String code) {
    // 参数验证
    if (phone.isEmpty || code.isEmpty) {
      throw ArgumentError('Phone and code cannot be empty');
    }
    if (phone.length != 11) {
      throw ArgumentError('Invalid phone number format');
    }
    if (code.length != 6) {
      throw ArgumentError('Invalid SMS code format');
    }
    return repository.loginWithSmsCode(phone: phone, code: code);
  }
}