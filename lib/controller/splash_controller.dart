import 'package:get/get.dart';
import 'package:ycsh/controller/auth_controller.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/view/splash/onboarding.dart';

class SplashController extends GetxController{

  void Proceed() async{
    await Future.delayed(const Duration(seconds: AppInteger.SPLASH_DURATION_SEC));
    _goToLogin();
  }


  void _goToLogin(){
    AppNavigator.navigateToReplace((){
      Get.delete<SplashController>();
      Get.put(AuthController());
      return OnboardingScreen();
    });
  }

}