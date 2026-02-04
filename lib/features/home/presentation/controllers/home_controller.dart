import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gzc_app/core/constants/routes.dart';

final bannerProvider =
    AsyncNotifierProvider<BannerNotifier, List<String>>(BannerNotifier.new);

final fnProvider = AsyncNotifierProvider<FnNotifier, List<FnData>>(
  FnNotifier.new,
);

final caseProvider =
    AsyncNotifierProvider<CaseNotifier, List<Map<String, String>>>(
  CaseNotifier.new,
);

class BannerNotifier extends AsyncNotifier<List<String>> {
  static const Duration _minLoadingDuration = Duration(milliseconds: 300);

  @override
  Future<List<String>> build() async {
    return _load();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<List<String>> _load() async {
    final startTime = DateTime.now();
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      return const [
        'https://picsum.photos/300/200?random=2',
        'https://picsum.photos/300/200?random=3',
        'https://picsum.photos/300/200?random=4',
      ];
    } finally {
      final elapsed = DateTime.now().difference(startTime);
      if (elapsed < _minLoadingDuration) {
        await Future.delayed(_minLoadingDuration - elapsed);
      }
    }
  }
}

class FnData {
  final IconData icon;
  final String title;
  final String route;
  FnData({
    required this.icon,
    required this.title,
    required this.route
  });
}

class FnNotifier extends AsyncNotifier<List<FnData>> {
  static const Duration _minLoadingDuration = Duration(milliseconds: 300);

  @override
  Future<List<FnData>> build() async {
    return _load();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<List<FnData>> _load() async {
    final startTime = DateTime.now();
    try {
      await Future.delayed(const Duration(milliseconds: 600));
      return <FnData>[
        FnData(icon: Icons.camera, title: "手机拍照", route: AppRoutes.takingPictures),
        FnData(icon: Icons.phone, title: "手机录像", route: AppRoutes.recordVideo),
        FnData(icon: Icons.live_tv, title: "现场录音", route: AppRoutes.liveRecording),
        FnData(icon: Icons.record_voice_over, title: "电话录音", route: AppRoutes.phoneRecording),
        FnData(icon: Icons.screen_lock_landscape, title: "屏幕录制", route: AppRoutes.screenRecording),
        FnData(icon: Icons.sms, title: "短信取证", route: AppRoutes.smsForensics),
        FnData(icon: Icons.copyright, title: "版权保护", route: "none"),
        FnData(icon: Icons.email, title: "邮件认证", route: "none"),
        FnData(icon: Icons.electric_scooter_outlined, title: "电子合同", route: AppRoutes.electronicContract),
        FnData(icon: Icons.web, title: "网页取证", route: AppRoutes.webForensics),

        // {'icon': 'camera', 'title': '手机拍照'},
        // {'icon': 'videocam', 'title': '手机录像'},
        // {'icon': 'mic', 'title': '现场录音'},
        // {'icon': 'phone', 'title': '电话录音'},
        // {'icon': 'screen', 'title': '屏幕录制'},
        // {'icon': 'sms', 'title': '短信取证'},
        // {'icon': 'copyright', 'title': '版权保护'},
        // {'icon': 'email', 'title': '邮件认证'},
        // {'icon': 'contract', 'title': '电子合同'},
        // {'icon': 'web', 'title': '网页取证'},
      ];
    } finally {
      final elapsed = DateTime.now().difference(startTime);
      if (elapsed < _minLoadingDuration) {
        await Future.delayed(_minLoadingDuration - elapsed);
      }
    }
  }
}

class CaseNotifier extends AsyncNotifier<List<Map<String, String>>> {
  static const Duration _minLoadingDuration = Duration(milliseconds: 300);

  @override
  Future<List<Map<String, String>>> build() async {
    return _load();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<List<Map<String, String>>> _load() async {
    final startTime = DateTime.now();
    try {
      await Future.delayed(const Duration(milliseconds: 1000));
      return const [
        {'title': '网购', 'desc': '适用于网络平台侵权购物'},
        {'title': '售货实录', 'desc': '适用于电子书、直播等无实体证物的维权场景'},
        {'title': '售货实录', 'desc': '适用于电子书、直播等无实体证物的维权场景'},
        {'title': '售货实录', 'desc': '适用于电子书、直播等无实体证物的维权场景'},
        {'title': '售货实录', 'desc': '适用于电子书、直播等无实体证物的维权场景'},
        {'title': '售货实录', 'desc': '适用于电子书、直播等无实体证物的维权场景'},
      ];
    } finally {
      final elapsed = DateTime.now().difference(startTime);
      if (elapsed < _minLoadingDuration) {
        await Future.delayed(_minLoadingDuration - elapsed);
      }
    }
  }
}

// 全局保留
// final userProvider = NotifierProvider<UserNotifier, User>(UserNotifier.new);

// 页面退出后自动清理
// final formProvider = NotifierProvider.autoDispose<FormNotifier, FormData>(FormNotifier.new);