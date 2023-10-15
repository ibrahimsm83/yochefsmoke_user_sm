import 'package:get/get.dart';
import 'package:ycsh/controller/auth_controller.dart';
import 'package:ycsh/controller/user/controllers.dart';
import 'package:ycsh/model/user.dart';
import 'package:ycsh/service/cloud.dart';
import 'package:ycsh/service/local_database.dart';
import 'package:ycsh/service/notification.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/view/dashboard/dashboard.dart';
import 'package:ycsh/view/splash/onboarding/onboarding.dart';

class SplashController extends GetxController{

  void Proceed() async{
    await Future.delayed(const Duration(seconds: AppInteger.SPLASH_DURATION_SEC));
    final LocalDatabase database=Get.find<LocalDatabase>();
    var cd=CloudDatabase();
    await NotificationService().init();
    await cd.init();
    await database.init();
    StakeHolder? user=database.getUserToken();
    if(user!=null){
      print("access token: ${user.accesstoken}");
      Map? map=await cd.getInitialMessage();
      _goToDashboard(user,initialMap: map);
    }
    else {
      _goToLogin();
    }
  }


  void _goToLogin(){
    Get.delete<SplashController>();
    AppNavigator.navigateToReplace((){
      Get.put(AuthController());
      return OnboardingScreen();
    });
  }

  void _goToDashboard(StakeHolder user,{Map? initialMap}){
    Get.delete<SplashController>();
    AppNavigator.navigateToReplace((){
      Get.put(DashboardController(user as User,initialMap: initialMap));
      Get.put(ProductController());
      Get.put(CartController());
      Get.put(ProfileController());
      Get.put(OrderController());
      Get.put(PaymentController());
      Get.put(TrackingController());
      return DashboardScreen();
    });
  }

}