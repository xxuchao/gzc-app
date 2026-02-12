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
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white, // 修改这里设置底部区域颜色
            systemNavigationBarIconBrightness: Brightness.dark, // 图标颜色
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          child: MaterialApp.router(
            title: '云尚公证处',
            theme: appLightTheme,
            debugShowCheckedModeBanner: true,
            routerConfig: AppRouter.router,
          ),
        );
      },
    );
  }
}
