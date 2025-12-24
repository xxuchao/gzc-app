
import "../repositories/auth_repository.dart";
import "../entities/user.dart";

class LoginUsecase {
  final AuthRespository repository;

  LoginUsecase({required this.repository});

  Future<User> call(String phone, String password) {
    return repository.loginWithPassword(phone: "xxx", password: "xxx");
  }
}