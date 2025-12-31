import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gzc_app/core/utils/devices.dart';
import 'package:gzc_app/core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light, // 控制状态栏图标的亮度（iOS）
    ),
  );

  configureDependencies(); // 初始化 DI
  await getIt.allReady();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceUtils.init(context);
    return ScreenUtilInit(
      designSize: const Size(390, 844), // const Size(375, 812)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: '云尚公证处',
          theme: appLightTheme,
          debugShowCheckedModeBanner: true,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
