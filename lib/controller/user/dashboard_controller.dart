import 'package:get/get.dart';
import 'package:ycsh/controller/auth_controller.dart';
import 'package:ycsh/model/location.dart';
import 'package:ycsh/model/user.dart';
import 'package:ycsh/service/local_database.dart';
import 'package:ycsh/service/repositories/address_provider.dart';
import 'package:ycsh/service/repositories/auth_provider.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/config.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/view/splash/onboarding/onboarding.dart';
import 'package:http/http.dart' as http;

class DashboardController extends GetxController{

  final LocalDatabase _database=Get.find<LocalDatabase>();
  final AuthProvider _authProvider=AuthProvider();

  final AddressProvider addressProvider=AddressProvider();

  final User user;
  DashboardController(this.user,);


  Future<void> editProfile(String fullname, String phone,{String? image,
    Location? location}) async{
    AppLoader.showLoader();
    var stak=await _authProvider.updateProfile(user.accesstoken!,fullname,phone,
        image: image,location: location);
    AppLoader.dismissLoader();
    if(stak!=null){
      user.fullname=stak.fullname;
      user.phone=stak.phone;
      user.image=stak.baseImage;
      user.location=(stak as User).location;
      saveUser();
      AppNavigator.pop();
    }
  }

  void saveUser(){
    _database.saveUser(user);
    update();
  }

  void logout() async{
    AppLoader.showLoader();
    bool status=await _authProvider.logoutUser(user.accesstoken!);
    AppLoader.dismissLoader();
    if(status){
      _goToLogin();
    }
  }

  void _goToLogin(){
    _database.removeUser();
    AppNavigator.navigateToReplaceAll((){
      Get.put(AuthController());
      return OnboardingScreen();
    });
  }

  void postContactUs(String name,String email,String message,) async{
    AppLoader.showLoader();
    bool status=await addressProvider.postContactUs(user.accesstoken!,
        name,email,message);
    AppLoader.dismissLoader();
    if(status){
      AppNavigator.pop();
    }
  }

  static void onBackgroundTap(Map map) async{

  }
}