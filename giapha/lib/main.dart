import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giapha/core/values/app_constants.dart';
import 'package:giapha/core/values/app_routes.dart';
import 'package:giapha/di/di.dart';
import 'package:giapha/features/access/presentation/pages/login_page.dart';
import 'package:giapha/features/access/presentation/pages/register_page.dart';
import 'package:giapha/shared/themes/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDiGiaPha();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 736),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: ((context, child) {
        return MaterialApp(
          title: "GiaPha",
          theme: ThemeDataShared.themeMain,
          builder: EasyLoading.init(),
          initialRoute: AppRoutes.loginScreen,
          navigatorKey: AppConstants.navigationKey,
          routes: {
            AppRoutes.loginScreen: (context) =>  loginBuilder(context),
            AppRoutes.registerScreen: (context) =>  registerBuilder(context),
          },
        );
      }),
    );
  }
}
