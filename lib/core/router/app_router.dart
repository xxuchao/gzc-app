import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gzc_app/core/constants/routes.dart';
import 'package:gzc_app/core/router/bootstrap_page.dart';
import 'package:gzc_app/core/router/error_page.dart';
import 'package:gzc_app/core/widgets/main_view.dart';
import 'package:gzc_app/features/address_management/presentation/pages/add_address.dart';
import 'package:gzc_app/features/address_management/presentation/pages/address_management.dart';
import 'package:gzc_app/features/applicant_management/presentation/pages/applicant_detail.dart';
import 'package:gzc_app/features/applicant_management/presentation/pages/applicant_management.dart';
import 'package:gzc_app/features/auth/presentation/pages/forget_password.dart';
import 'package:gzc_app/features/auth/presentation/pages/login_with_one_tap.dart';
import 'package:gzc_app/features/auth/presentation/pages/login_with_password.dart';
import 'package:gzc_app/features/auth/presentation/pages/login_with_sms.dart';
import 'package:gzc_app/features/fee_standard/presentation/pages/fee_standard.dart';
import 'package:gzc_app/features/profile/presentation/pages/my_profile_page.dart';
import 'package:gzc_app/features/setting/presentation/pages/setting.dart';

enum RouteTransitionType {
  slideRightToLeft,
  modalBottom,
}

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static CustomTransitionPage<T> _buildTransitionPage<T>({
    required GoRouterState state,
    required Widget child,
    RouteTransitionType transition = RouteTransitionType.slideRightToLeft,
  }) {
    switch (transition) {
      case RouteTransitionType.modalBottom:
        return CustomTransitionPage<T>(
          key: state.pageKey,
          child: child,
          opaque: false,
          barrierDismissible: true,
          barrierColor: Colors.black54,
          transitionDuration: const Duration(milliseconds: 250),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );

            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(curved),
                child: child,
              ),
            );
          },
        );
      case RouteTransitionType.slideRightToLeft:
        return CustomTransitionPage<T>(
          key: state.pageKey,
          child: child,
          transitionDuration: const Duration(milliseconds: 250),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            );
          },
        );
    }
  }

  static GoRoute _route(
    String path,
    Widget Function(GoRouterState state) builder, {
    RouteTransitionType transition = RouteTransitionType.slideRightToLeft,
  }) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) => _buildTransitionPage(
        state: state,
        child: builder(state),
        transition: transition,
      ),
    );
  }

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.bootstrap,
    errorBuilder: (context, state) =>
        ErrorPage(routeName: state.uri.toString()),
    routes: <RouteBase>[
      _route(
        AppRoutes.bootstrap,
        (state) => const BootstrapPage(),
      ),
      _route(
        AppRoutes.loginWithPassword,
        (state) => const LoginWithPasswordPage(),
      ),
      _route(
        AppRoutes.loginWithOneTap,
        (state) => const LoginWithOneTapPage(),
      ),
      _route(
        AppRoutes.loginWithSms,
        (state) => const LoginWithSmsPage(),
      ),
      _route(
        AppRoutes.forgetPassword,
        (state) => const ForgetPasswordPage(),
      ),
      _route(
        AppRoutes.home,
        (state) => const MainView(),
      ),
      _route(
        AppRoutes.profile,
        (state) => const MyProfilePage(),
      ),
      _route(
        AppRoutes.applicantManagement,
        (state) => const ApplicantManagementPage(),
      ),
      _route(
        AppRoutes.applicantDetail,
        (state) => ApplicantDetail(),
      ),
      _route(
        AppRoutes.addressManagement,
        (state) => const AddressManagement(),
      ),
      _route(
        AppRoutes.addAddress,
        (state) => const AddAddressPage(),
        transition: RouteTransitionType.modalBottom,
      ),
      _route(
        AppRoutes.feeStandard,
        (state) => FeeStandardPage(),
      ),
      _route(
        AppRoutes.settings,
        (state) => SystemSettingsPage(),
      ),
      _route(
        AppRoutes.dashboard,
        (state) => ErrorPage(routeName: state.uri.toString()),
      ),
      _route(
        AppRoutes.invoiceManagement,
        (state) => ErrorPage(routeName: state.uri.toString()),
      ),
      _route(
        AppRoutes.about,
        (state) => ErrorPage(routeName: state.uri.toString()),
      ),
    ],
  );

  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return router.push<T>(routeName, extra: arguments);
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    router.go(routeName, extra: arguments);
    return Future<T?>.value(result as T?);
  }

  static void pop<T extends Object?>([T? result]) {
    if (router.canPop()) {
      router.pop<T>(result);
      return;
    }
    router.go(AppRoutes.home);
  }

  static Future<void> toLogin() async {
    router.go(AppRoutes.loginWithPassword);
  }

  static Future<void> toHome() async {
    router.go(AppRoutes.home);
  }
}
