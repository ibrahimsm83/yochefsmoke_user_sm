import 'package:get/get.dart';
import 'package:ycsh/controller/auth_controller.dart';
import 'package:ycsh/model/address.dart';
import 'package:ycsh/model/interface.dart';
import 'package:ycsh/model/location.dart';
import 'package:ycsh/model/notification.dart';
import 'package:ycsh/model/order.dart';
import 'package:ycsh/model/user.dart';
import 'package:ycsh/service/cloud.dart';
import 'package:ycsh/service/local_database.dart';
import 'package:ycsh/service/repositories/address_provider.dart';
import 'package:ycsh/service/repositories/auth_provider.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/config.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/view/dashboard/order_history/order_detail.dart';
import 'package:ycsh/view/splash/onboarding/onboarding.dart';
import 'package:http/http.dart' as http;
import 'package:ycsh/widget/dialog/message_dialog.dart';

class DashboardController extends GetxController implements FCMCallBack{

  final LocalDatabase _database=Get.find<LocalDatabase>();
  final AuthProvider _authProvider=AuthProvider();

  final AddressProvider addressProvider=AddressProvider();

  final CloudDatabase _cloud= CloudDatabase();

  Map? _initialMap;

  final User user;
  DashboardController(this.user,{Map? initialMap}){
    _initialMap=initialMap;
  }


  @override
  void onInit() {
    _cloud.setFCMCallback(this);
    super.onInit();
  }

  @override
  void onClose() {
    _cloud.removeFCMCallback();
    // _notificationService.removeNotificationCallBack();
    super.onClose();
  }

  @override
  void onReady() {
    if(_initialMap!=null){
      onNotificationTap(_initialMap!);
    }
    super.onReady();
  }

  Future<void> editProfile(String fullname, String phone,{String? image,
    Address? location}) async{
    AppLoader.showLoader();
    var stak=await _authProvider.updateProfile(user.accesstoken!,fullname,phone,
        image: image,location: location);
    AppLoader.dismissLoader();
    if(stak!=null){
      user.fullname=stak.fullname;
      user.phone=stak.phone;
      user.image=stak.baseImage;
      user.address=(stak as User).address;
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

  @override
  void onNotificationTap(Map map) {
    print("not map: $map");
    final String type=map["type"];
    redirectNotification(_getNotification(type,map));
  }



  @override
  void onForeground(Map map) {
    final String type=map["type"];
    var notification=_getNotification(type,map);
   // if(type==Notification.TYPE_ORDER_STATUS){
      AppDialog.showDialog(MessageDialog(message: notification.body!,onDone:(){
        redirectNotification(notification);
      },));
   // }
  }

  void redirectNotification(Notification notification){
    if(notification.type==Notification.TYPE_ORDER_STATUS ||
        notification.type==Notification.TYPE_ASSIGN){
      AppNavigator.navigateTo(OrderDetailScreen(order: notification.data,load: true,));
    }
  }

  Notification _getNotification(String type,Map map){
    var notData = (type==Notification.TYPE_ORDER_STATUS ||
        type==Notification.TYPE_ASSIGN)?Order(id: map["related_id"])
        :null;
    var notification=Notification.fromMap(map,data: notData,
       // sender: User(id: map["sender_id"])
    );
    return notification;
  }

  static void onBackgroundTap(Map map) async{

  }
}