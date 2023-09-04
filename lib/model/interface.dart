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