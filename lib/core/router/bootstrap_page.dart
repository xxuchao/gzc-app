import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gzc_app/core/constants/routes.dart';
import 'package:gzc_app/core/constants/storage_keys.dart';
import 'package:gzc_app/core/local_storage/storage_service.dart';
import 'package:gzc_app/injection.dart';

class BootstrapPage extends StatefulWidget {
  const BootstrapPage({super.key});

  @override
  State<BootstrapPage> createState() => _BootstrapPageState();
}

class _BootstrapPageState extends State<BootstrapPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bootstrap();
    });
  }

  Future<void> _bootstrap() async {
    final localStorage = getIt<LocalStorageService>();
    final token = await localStorage.getString(StorageKeys.authToken);

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    if ((token ?? "").isNotEmpty) {
      context.go(AppRoutes.home);
    } else {
      final targetRoute = AppRoutes.loginWithSms;
      // TODO: 判断能否获取本机号码跳转不同的登录界面
      context.go(targetRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
