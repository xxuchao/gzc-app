
import "../repositories/auth_repository.dart";
import "../entities/user.dart";

class LoginPasswordUsecase {
  final AuthRespository repository;

  LoginPasswordUsecase({required this.repository});

  Future<User> call(String phone, String password) {
    return repository.loginWithPassword(phone: phone, password: password);
  }
}