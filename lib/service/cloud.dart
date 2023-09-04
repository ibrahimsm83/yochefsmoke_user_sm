import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:ycsh/controller/user/dashboard_controller.dart';
import 'dart:developer';

import 'package:ycsh/model/interface.dart';


class CloudDatabase extends GetxService{

  static CloudDatabase? _instance;

  String? _fcmToken;
  //static CloudDatabase? _instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FCMCallBack? _fcmCallBack;

  //FCMCallBack _onMessageCallBack;

  CloudDatabase._();

  factory CloudDatabase(){
    return _instance??=CloudDatabase._();
  }

  Future<void> setPresentationOptions({bool alert = true, bool badge=true, bool sound=true,}) async{
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(alert: alert,badge: badge,sound: sound);
  }

  Future<void> init() async{

    await _firebaseMessaging.requestPermission();

    await setPresentationOptions(alert: false);

    _fcmToken = await _firebaseMessaging.getToken();
    print("fcm token: $_fcmToken");

    //  var settings=await _firebaseMessaging.getNotificationSettings();
//    print("not settings: ${settings.sound}");

    FirebaseMessaging.onMessage.listen((event) {
      log("fcm data: ${event.data}");
      // if(_fcmCallBack!=null) {
      _fcmCallBack?.onForeground(event.data);
      //   }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      log("fcm data on opened: ${event.data}");
      //if(_fcmCallBack!=null){
      _fcmCallBack?.onNotificationTap(event.data);
      // }
    });
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);


  }


 // FCMCallBack get fcmCallBack => _fcmCallBack!;

  Future<Map?> getInitialMessage() async{
    var remote=await _firebaseMessaging.getInitialMessage();
    return remote?.data;
  }

  static Future<void> _onBackgroundMessage(RemoteMessage event) async{
    log("fcm data background: ${event.data}");
    DashboardController.onBackgroundTap(event.data);
  }


  String? get fcmToken => _fcmToken;

  void setFCMCallback(FCMCallBack callBack){
    assert(_fcmCallBack==null);
    _fcmCallBack=callBack;
  }

  void removeFCMCallback(){
    assert(_fcmCallBack!=null);
    _fcmCallBack=null;
  }


}