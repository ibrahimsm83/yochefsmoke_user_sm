import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ycsh/controller/splash_controller.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/splash_items.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final SplashController controller=Get.find<SplashController>();

  @override
  void initState() {
    controller.Proceed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashBackground(child: Scaffold(
      backgroundColor: AppColor.COLOR_TRANSPARENT,
      body: Center(child: const AppLogo(width: AppDimen.SPLASH_LOGO_WIDTH,
        height: AppDimen.SPLASH_LOGO_HEIGHT,),),
    ),);
  }
}
