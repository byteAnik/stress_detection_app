import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:stress_detection_app/constants/app_colors.dart';
import 'package:stress_detection_app/constants/custome_theme.dart';
import 'package:stress_detection_app/features/auth/create_password/presentation/create_password_screen.dart';
import 'package:stress_detection_app/features/auth/otp_verify/presentation/otp_verify_screen.dart';
import 'package:stress_detection_app/features/home/presentation/home_screen.dart';
import 'package:stress_detection_app/features/monitoring/presentation/monitoring_screen.dart';
import 'package:stress_detection_app/helpers/di.dart';
import 'package:stress_detection_app/helpers/helper_methods.dart';
import 'package:stress_detection_app/helpers/navigation_service.dart';
import 'package:stress_detection_app/helpers/register_provider.dart';
import 'package:stress_detection_app/networks/dio/dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  diSetup();
  initiInternetChecker();
  DioSingleton.instance.create();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    rotation();
    setInitValue();
    return MultiProvider(
      providers: providers,
      child: AnimateIfVisibleWrapper(
        showItemInterval: const Duration(milliseconds: 150),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return const UtillScreenMobile();
          },
        ),
      ),
    );
  }
}

class UtillScreenMobile extends StatelessWidget {
  const UtillScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          showPerformanceOverlay: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: AppColors.white,
            ),
            primarySwatch: CustomTheme.kToDark,
            scaffoldBackgroundColor: AppColors.white,
            useMaterial3: false,
          ),
          debugShowCheckedModeBanner: false,
          builder: (context, widget) {
            return MediaQuery(data: MediaQuery.of(context), child: widget!);
          },
          navigatorKey: NavigationService.navigatorKey,
          home: MonitoringScreen(),
        );
      },
    );
  }
}
