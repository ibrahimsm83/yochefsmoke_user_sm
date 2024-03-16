import 'package:get/get.dart';
import 'package:ycsh/controller/user/controllers.dart';
import 'package:ycsh/model/location.dart';
import 'package:ycsh/model/user.dart';
import 'package:ycsh/service/local_database.dart';
import 'package:ycsh/service/repositories/auth_provider.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/view/dashboard/dashboard.dart';

class AuthController extends GetxController {
  final AuthProvider _authProvider = AuthProvider();
  final LocalDatabase database = Get.find<LocalDatabase>();

  void signUp(String fullname, String email, String password, String phone,
      {Location? location}) async {
    //  if(_location!=null) {
    if (location != null) {
      AppLoader.showLoader();
      StakeHolder? user = await _authProvider
          .signUpUser(fullname, email, password, phone, location: location);
      AppLoader.dismissLoader();
      if (user != null) {
        _goToDashboard(user);
      }
    } else {
      AppMessage.showMessage("Please select location");
    }
  }

  Future<bool> forgetPassword(email) async {
    AppLoader.showLoader();
    var isForget = await _authProvider.forgetpassword(email);
    AppLoader.dismissLoader();
    if (isForget != null) {
      return isForget;
    }
    return false;
  }

  changePassword(String email, String otp, String pass, String conpass) async {
    AppLoader.showLoader();
    var isForget =
        await _authProvider.changePassword(email, otp, pass, conpass);
    AppLoader.dismissLoader();
    if (isForget != null) {
      return isForget;
    }
    return false;
  }

  void login(String email, String password) async {
    AppLoader.showLoader();
    StakeHolder? user = await _authProvider.loginUser(email, password, "");
    AppLoader.dismissLoader();
    if (user != null) {
      if(user!.role =="user"){
        _goToDashboard(user);
      }
      else{
        AppMessage.showMessage("Invalid Account Type");
      }
    }
  }

  void _goToDashboard(StakeHolder user) {
    database.saveUser(user);
    //Get.delete<AuthController>();
    AppNavigator.navigateToReplaceAll(() {
      Get.put(DashboardController(user as User));
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
