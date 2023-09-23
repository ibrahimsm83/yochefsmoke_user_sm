import 'package:ycsh/model/location.dart';

mixin DropDownItem{

  String getId();
  String getText();

  @override
  bool operator == (Object other) {
    return other is DropDownItem && other.getId()==getId();
  }

}

abstract class FCMCallBack{
  void onNotificationTap(Map data);
  void onForeground(Map map);
//void onBackgroundTap(Map data);
}

abstract class LocationInterface{
  void onLocationChanged(Location location);
}

mixin SocketMessageHandler{
  void onConnect(data){
    print("socket connected: $data");
  }
  void onDisconnect(data){
    print("socket disconnected: $data");
  }

  void onConnectionError(data){
    print("socket connection error: $data");
  }

  void onError(data){
    print("socket error: $data");
  }

  void onEvent(String name,data){
    print("socket event triggered: ${name} with ${data}");
  }

}