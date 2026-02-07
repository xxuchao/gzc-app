// # GetX Controller (替代 BLoC/Cubit)

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/net_client.dart';

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
  final NetClient _dioClient = NetClient();

  @override
  AuthState build() {
    _checkLoginStatus();
    return AuthState.initial();
  }

  void _checkLoginStatus() {
    state = state.copyWith(isLoggedIn: false);
  }

  Future<void> login(String username, String password) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: '');

      await Future.delayed(const Duration(seconds: 1));

      if (username == 'admin' && password == 'password') {
        state = state.copyWith(
          userInfo: const {
            'id': '1',
            'name': '张三',
            'username': 'admin',
            'avatar': 'https://via.placeholder.com/100',
          },
          isLoggedIn: true,
        );
      } else {
        throw Exception('用户名或密码错误');
      }
    } catch (e) {
      state = state.copyWith(errorMessage: '登录失败: ${e.toString()}');
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
