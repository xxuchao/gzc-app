import 'package:flutter_riverpod/flutter_riverpod.dart';
import "../../domain/usecases/login_usecase.dart";

final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

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


class AuthNotifier extends Notifier<AuthState> {

  @override
  AuthState build() {
    _checkLoginStatus();
    return AuthState.initial();
  }

  void _checkLoginStatus() {
    state = state.copyWith(isLoggedIn: false);
  }
}
