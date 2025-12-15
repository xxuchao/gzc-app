import 'package:flutter_riverpod/flutter_riverpod.dart';

final bannerProvider =
    AsyncNotifierProvider<BannerNotifier, List<String>>(BannerNotifier.new);

final fnProvider = AsyncNotifierProvider<FnNotifier, List<Map<String, String>>>(
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

class FnNotifier extends AsyncNotifier<List<Map<String, String>>> {
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
      await Future.delayed(const Duration(milliseconds: 600));
      return const [
        {'icon': 'camera', 'title': '手机拍照'},
        {'icon': 'videocam', 'title': '手机录像'},
        {'icon': 'mic', 'title': '现场录音'},
        {'icon': 'phone', 'title': '电话录音'},
        {'icon': 'screen', 'title': '屏幕录制'},
        {'icon': 'sms', 'title': '短信取证'},
        {'icon': 'copyright', 'title': '版权保护'},
        {'icon': 'email', 'title': '邮件认证'},
        {'icon': 'contract', 'title': '电子合同'},
        {'icon': 'web', 'title': '网页取证'},
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