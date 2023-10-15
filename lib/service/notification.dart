import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:ycsh/model/interface.dart';
import 'package:ycsh/utils/config.dart';

class NotificationService extends GetxService{

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  NotificationCallBack? _callBack;

  static NotificationService? _instance;

  NotificationService._();

  factory NotificationService(){
    return _instance??=NotificationService._();
  }


  Future<void> init() async{
    final bool? result = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation
    <AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(
        const AndroidNotificationChannel(AppConfig.NOTIFCATION_CHANNEL_ID,
            AppConfig.NOTIFCATION_CHANNEL_NAME,
            description: AppConfig.NOTIFCATION_CHANNEL_DESCRIPTION,
           // sound: RawResourceAndroidNotificationSound(AppConfig.RINGTONE1),
            importance: Importance.max,playSound: true,enableVibration: true,));
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload,) {
          print("local notification 2: ${this._callBack} $payload");
          if(_callBack!=null) {
            _callBack!.onLocalNotificationTap(payload!);
          }
        });

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      //macOS: initializationSettingsMacOS,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload){
          print("local notification: ${this._callBack} $payload");
          if(_callBack!=null) {
            _callBack!.onLocalNotificationTap(payload!);
          }
        });
  }

  Future<String?> getInitialMessage() async{
    var remote=await _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if(remote!=null) {
      return remote.payload;
    }
  }

 /* void showCallNotification(Notification notification,{String? data=""}) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    // /Volumes/DATA/installed-softwares/flutter/.pub-cache/hosted/pub.dartlang.org/flutter_local_notifications-9.4.0/lib/src/platform_specifics/android/person.dart
    AndroidNotificationDetails(
        AppConfig.NOTIFCATION_CHANNEL_ID,
        AppConfig.NOTIFCATION_CHANNEL_NAME,
        channelDescription:AppConfig.NOTIFCATION_CHANNEL_DESCRIPTION,
        importance: Importance.max,
        priority: Priority.max,
        channelShowBadge: true,
        usesChronometer: false,
        // ticker: "abc",
        // channelAction: AndroidNotificationChannelAction.update,
        sound: const RawResourceAndroidNotificationSound(AppConfig.DEFAULT_CALL_NOTIFICATION_SOUND),
        //   sound: UriAndroidNotificationSound(_soundUri),
        autoCancel: false,
        //  autoCancel: true,
        ongoing: true,
        //  ongoing:false,
        playSound: true,
        *//*      styleInformation: InboxStyleInformation(
            [],
            contentTitle: '2 messages',
            summaryText: 'janedoe@example.com'),*//*
        enableVibration: true,
        //  timeoutAfter: AppInteger.INCOMING_CALL_TIMEOUT,
        fullScreenIntent: true,
        //  fullScreenIntent: false,
        visibility: NotificationVisibility.public,
        additionalFlags: Int32List.fromList(<int>[2,32],)
    );
    final IOSNotificationDetails iosPlatformChannelSpecifics=IOSNotificationDetails(
      badgeNumber: 0, presentAlert: true,
      presentBadge: true, presentSound: true,
      sound: "${AppConfig.DEFAULT_CALL_NOTIFICATION_SOUND}.aiff",
      // subtitle: "subtitle"
    );

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iosPlatformChannelSpecifics,);
    // await CloudDatabase().setPresentationOptions(alert: true,);
    await _flutterLocalNotificationsPlugin.show(
      int.parse(notification.id!), notification.title,
      notification.body, platformChannelSpecifics, payload: data,
    );
    //  CloudDatabase().setPresentationOptions(alert: false);
  }*/

  void setNotificationCallBack(NotificationCallBack callBack){
    assert(_callBack==null);
    this._callBack=callBack;
    //print("callback $_callBack");
  }

  void removeNotificationCallBack(){
    assert(_callBack!=null);
    this._callBack=null;
  }

  void removeNotification(int id){
    _flutterLocalNotificationsPlugin.cancel(id);
  }

}