import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gzc_app/core/utils/devices.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/main_view.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies(); // 初始化 DI
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
        return MaterialApp(
          title: '云尚公证处',
          theme: appLightTheme,
          debugShowCheckedModeBanner: true,
          home: const MainView(),
        );
      },
    );
  }
}
