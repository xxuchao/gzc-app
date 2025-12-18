import 'package:flutter/material.dart';
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

    if (!mounted) return;

    final targetRoute = (token != null && token.isNotEmpty)
        ? AppRoutes.home
        : AppRoutes.login;
    await Future.delayed(const Duration(milliseconds: 500));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed(targetRoute);
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
