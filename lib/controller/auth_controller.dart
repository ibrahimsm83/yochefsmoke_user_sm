import 'package:get/get.dart';
import 'package:ycsh/controller/user/controllers.dart';
import 'package:ycsh/model/location.dart';
import 'package:ycsh/model/user.dart';
import 'package:ycsh/service/local_database.dart';
import 'package:ycsh/service/repositories/auth_provider.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/view/dashboard/dashboard.dart';

class AuthController extends GetxController{

  final AuthProvider _authProvider=AuthProvider();
  final LocalDatabase database=Get.find<LocalDatabase>();

  void signUp(String fullname, String email, String password, String phone,
      {Location? location}) async{
    //  if(_location!=null) {
    if(location!=null) {
      AppLoader.showLoader();
      StakeHolder? user = await _authProvider.signUpUser(
        fullname, email, password, phone,location: location);
      AppLoader.dismissLoader();
      if (user != null) {
        _goToDashboard(user);
      }
    }
    else{
      AppMessage.showMessage("Please select location");
    }
  }

  void login(String email,String password) async{
    AppLoader.showLoader();
    StakeHolder? user = await _authProvider.loginUser(
        email, password,"");
    AppLoader.dismissLoader();
    if (user != null) {
      _goToDashboard(user);
/*      if(user is! Dentist){
        if (user.isVerified!) {
          _goToDashboard(user);
        }
        else {
          bool status = await resendOtpCode(user.id!,);
          if (status) {
            AppNavigator.navigateTo(EnterOtpScreen(
              onResend: () {
                resendOtpCode(user.id!,);
              },
              email: email,
              onSubmit: (val) {
                _verifySignUpOtp(user.id!, val,);
              },));
          }
        }
      }
      else{
        _goToDashboard(user);
      }*/
    }
  }

  void _goToDashboard(StakeHolder user){
    database.saveUser(user);
    //Get.delete<AuthController>();
    AppNavigator.navigateToReplaceAll((){
      Get.put(DashboardController(user as User));
      Get.put(ProductController());
      Get.put(CartController());
      Get.put(AddressController());
      Get.put(OrderController());
      Get.put(PaymentController());
      return DashboardScreen();
    });

  }
}