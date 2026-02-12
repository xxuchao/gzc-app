import "../repositories/auth_repository.dart";
import "../entities/user.dart";

class LoginOnetapUsecase {
  final AuthRespository repository;

  LoginOnetapUsecase({required this.repository});

  Future<User> call(String phone, String accessToken) {
    return repository.loginWithOneTap(phoneNumber: phone, accessToken: accessToken);
  }
}