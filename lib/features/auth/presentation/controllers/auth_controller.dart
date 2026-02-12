// # GetX Controller (替代 BLoC/Cubit)

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gzc_app/features/auth/domain/usecases/login_sms_usecase.dart';

class AuthState {
  final bool isLoading;
  final String errorMessage;
  final bool isLoggedIn;
  final Map<String, dynamic> userInfo;

  const AuthState({
    required this.isLoading,
    required this.errorMessage,
    required this.isLoggedIn,
    required this.userInfo,
  });

  factory AuthState.initial() => const AuthState(
    isLoading: false,
    errorMessage: '',
    isLoggedIn: false,
    userInfo: {},
  );

  AuthState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isLoggedIn,
    Map<String, dynamic>? userInfo,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      userInfo: userInfo ?? this.userInfo,
    );
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {

// 注入 UseCase
  late final LoginSmsUsecase _loginSmsUsecase;

  @override
  AuthState build() {
    _checkLoginStatus();
    return AuthState.initial();
  }

  void _checkLoginStatus() {
    state = state.copyWith(isLoggedIn: false);
  }

  Future<void> loginWithSms(String phone, String code) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: '');
      
      final user = await _loginSmsUsecase(phone, code); // 调用 UseCase
      
      state = state.copyWith(
        userInfo: {
          'id': user.id,
          'name': user.name,
          'email': user.email,
          'avatar': user.avatar,
          'orgName': user.orgName,
          'certification': user.certification,
        },
        isLoggedIn: true,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> logout() async {
    try {
      state = state.copyWith(isLoading: true);

      await Future.delayed(const Duration(seconds: 1));

      state = state.copyWith(userInfo: const {}, isLoggedIn: false);
    } catch (e) {
      state = state.copyWith(errorMessage: '退出登录失败: ${e.toString()}');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
