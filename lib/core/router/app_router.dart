import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gzc_app/core/constants/routes.dart';
import 'package:gzc_app/core/models/webview_args.dart';
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
import 'package:gzc_app/features/case_detail/presentation/pages/case_detail_page.dart';
import 'package:gzc_app/features/electronic_contract/presentation/pages/electronic_contract.dart';
import 'package:gzc_app/features/evidence_batch/presentation/pages/evidence_batch.dart';
import 'package:gzc_app/features/evidence_detail/presentation/pages/evidence_detail_page.dart';
import 'package:gzc_app/features/fee_standard/presentation/pages/fee_standard.dart';
import 'package:gzc_app/features/live_recording/presentation/pages/live_recording.dart';
import 'package:gzc_app/features/phone_recording/presentation/pages/phone_recording.dart';
import 'package:gzc_app/features/profile/presentation/pages/my_profile_page.dart';
import 'package:gzc_app/features/record_video/presentation/pages/record_video.dart';
import 'package:gzc_app/features/referral_code/presentation/pages/referral_code_page.dart';
import 'package:gzc_app/features/screen_recording/presentation/pages/screen_recording.dart';
import 'package:gzc_app/features/setting/presentation/pages/setting.dart';
import 'package:gzc_app/features/sms_forensics/presentation/pages/sms_forensics.dart';
import 'package:gzc_app/features/take_pictures/presentation/pages/take_pictures.dart';
import 'package:gzc_app/features/web_forensics/presentation/pages/web_forensics.dart';
import 'package:gzc_app/features/webview/webview.utils.dart';

enum RouteTransitionType {
  slideRightToLeft,
  modalBottom,
}

final homeRouter = <RouteBase>[
  AppRouter._route( // 首页四个
    AppRoutes.home,
    (state) => const MainView(),
  ),
  AppRouter._route( // 网页取证
    AppRoutes.webForensics,
    (state) => const WebForensics(),
  ),
  AppRouter._route( // 电子合同
    AppRoutes.electronicContract,
    (state) => const ElectronicContract(),
  ),
  AppRouter._route( // 拍照取证
    AppRoutes.takingPictures,
    (state) => const TakingPictures(),
  ),
  AppRouter._route( // 录像取证
    AppRoutes.recordVideo,
    (state) => const RecordVideo(),
  ),
  AppRouter._route( // 屏幕录制
    AppRoutes.screenRecording,
    (state) => const ScreenRecording(),
  ),
  AppRouter._route( // 短信取证
    AppRoutes.smsForensics,
    (state) => const SmsForensics(),
  ),
  AppRouter._route( // 现场录音
    AppRoutes.liveRecording,
    (state) => const LiveRecording(),
  ),
  AppRouter._route( // 电话录音
    AppRoutes.phoneRecording,
    (state) => const PhoneRecordingPage(),
  ),
];

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
      _route( // 启动页
        AppRoutes.bootstrap,
        (state) => const BootstrapPage(),
      ),
      _route( // webview
        AppRoutes.webview,
        (state) {
          final args = state.extra as WebViewArgs?;
          if (args == null) {
            return ErrorPage(routeName: state.uri.toString());
          }
          return WebViewPage(title: args.title, url: args.url);
        },
      ),
      _route( // 密码登录
        AppRoutes.loginWithPassword,
        (state) => const LoginWithPasswordPage(),
      ),
      _route( // 一键登录
        AppRoutes.loginWithOneTap,
        (state) => const LoginWithOneTapPage(),
      ),
      _route( // 验证码登录
        AppRoutes.loginWithSms,
        (state) => const LoginWithSmsPage(),
      ),
      _route( // 忘记密码
        AppRoutes.forgetPassword,
        (state) => const ForgetPasswordPage(),
      ),

      ...homeRouter,

      _route( // 案件详情
        AppRoutes.caseDetail,
        (state) => const CaseDetailPage(),
      ),
      _route( // 证据详情
        AppRoutes.evidenceDetail,
        (state) => const EvidenceDetailPage(),
      ),
      _route( // 批量操作证据
        AppRoutes.evidenceBatch,
        (state) => const EvidenceBatchPage(),
      ),
      _route( // 我的页面
        AppRoutes.profile,
        (state) => const MyProfilePage(),
      ),
      _route( // 申请人管理
        AppRoutes.applicantManagement,
        (state) => const ApplicantManagementPage(),
      ),
      _route( // 申请人详情
        AppRoutes.applicantDetail,
        (state) => ApplicantDetail(),
      ),
      _route( // 地址管理
        AppRoutes.addressManagement,
        (state) => const AddressManagement(),
      ),
      _route( // 添加地址
        AppRoutes.addAddress,
        (state) => const AddAddressPage(),
        transition: RouteTransitionType.modalBottom,
      ),
      _route( // 收费标准
        AppRoutes.feeStandard,
        (state) => FeeStandardPage(),
      ),
      _route( // 我的分享码
        AppRoutes.referralCode,
        (state) => ReferralCodePage(),
      ),
      _route( // 设置界面
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
