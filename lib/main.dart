import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ycsh/controller/bindings/bindings.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/view/dashboard/dashboard.dart';
import 'package:ycsh/view/registration/login.dart';
import 'package:ycsh/view/splash/onboarding.dart';
import 'package:ycsh/view/splash/splash.dart';

import 'utils/config.dart';

class MyHttpOverrides extends HttpOverrides {

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async{
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: AppColor.THEME_COLOR_PRIMARY1,
     // systemNavigationBarColor: AppColor.GREEN
    ));

    return ScreenUtilInit(
      minTextAdapt: true,splitScreenMode: true,
      builder: (con,wid){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConfig.APP_NAME,
          initialBinding: MyBinding(),
          theme: ThemeData(
            primaryColor: AppColor.THEME_COLOR_PRIMARY1,
            scaffoldBackgroundColor: AppColor.BG_COLOR,
            fontFamily: FontFamily.PRIMARY,
            primarySwatch: Colors.orange,

          ),

          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
         // home: LoginScreen(),
          home: SplashScreen(),
         // home: OnboardingScreen(),
        //   home: DashboardScreen(),
        );
      },
    );
  }
}
