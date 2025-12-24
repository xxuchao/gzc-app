import 'package:flutter/material.dart';
import 'package:gzc_app/core/constants/routes.dart';
import 'package:gzc_app/core/router/bootstrap_page.dart';
import 'package:gzc_app/core/router/error_page.dart';
import 'package:gzc_app/core/widgets/main_view.dart';
import 'package:gzc_app/features/auth/presentation/pages/login_with_sms.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // 启动页
      case AppRoutes.bootstrap:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const BootstrapPage(),
        );
      // 登录页
      case AppRoutes.loginWithPassword:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LoginWithPasswordPage(),
        );
      case AppRoutes.loginWithOneTap:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LoginWithPasswordPage(),
        );
      case AppRoutes.loginWithSms:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LoginWithPasswordPage(),
        );
      // 首页
      case AppRoutes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const MainView(),
        );
      // 其他
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ErrorPage(routeName: settings.name),
        );
    }
  }

  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!
        .pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushReplacementNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  static void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState!.pop<T>(result);
  }

  static Future<void> toLogin() {
    return pushReplacementNamed<void, void>(AppRoutes.loginWithPassword);
  }

  static Future<void> toHome() {
    return pushReplacementNamed<void, void>(AppRoutes.home);
  }
}
