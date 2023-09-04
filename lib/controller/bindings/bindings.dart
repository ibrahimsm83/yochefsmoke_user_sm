import 'package:get/get.dart';
import 'package:ycsh/controller/splash_controller.dart';
import 'package:ycsh/service/local_database.dart';

class MyBinding extends Bindings{

  @override
  void dependencies() {
    Get.put(LocalDatabase());
   /* Get.put(CloudDatabase());
    Get.put(LocationService());
    Get.put(NotificationService());
    Get.put(Unilinker());*/
    Get.put(SplashController());
    //Get.lazyPut(() => SplashController());
  }
}