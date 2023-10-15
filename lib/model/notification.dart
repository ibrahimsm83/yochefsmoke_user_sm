import 'package:ycsh/model/user.dart';
import 'package:ycsh/utils/datetime.dart';

class Notification{

  static const TYPE_ORDER_STATUS="change_order_status",TYPE_ASSIGN="rider_assign_order";

  final String? id,title,body,type;
  bool? _isRead;
  final String? dateTime;
  final StakeHolder? sender;
  final dynamic data;

  Notification({this.id, this.title, this.type, this.body, this.dateTime, this.sender, this.data,
    bool? isRead}){
    _isRead=isRead;
  }

  factory Notification.fromMap(Map map,{StakeHolder? sender,dynamic data}){
    String date=DateTimeManager.getFormattedDateTime((map["created_at"] as String)
        .replaceAll("T", " ").replaceAll("Z", ""),isutc: true,
        format: DateTimeManager.dateTimeFormat,format2: DateTimeManager.dateTimeFormat24);
    return Notification(id:map["id"],
    //  isRead: map["isRead"]==1,
     // title: map["title"],
      body: map["text"],
      type: map["type"],data: data,
      dateTime: date,
      sender: sender,);
  }


  bool get isRead => _isRead!;

  set isRead(bool value) {
    _isRead = value;
  }

  Map<String,dynamic> toLocalMap(){
    return {"type":type,"data":data};
  }


}