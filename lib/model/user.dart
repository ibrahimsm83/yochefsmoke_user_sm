import 'package:ycsh/model/location.dart';
import 'package:ycsh/utils/config.dart';

abstract class StakeHolder{

  static const TYPE_USER="user",TYPE_RIDER="rider";

  final String? id;
  final String? email;
  String? fullname,phone,_image;
  final String? accesstoken;
  StakeHolder({this.id, this.email, this.fullname, this.phone,String?image,
    this.accesstoken,}){
    _image=image;
  }

  get baseImage=>_image;

  get image => AppConfig.IMAGE_URL+(_image??"");

  set image(value) {
    _image = value;
  }

  Map<String,dynamic> toLocalMap(){
    return {"id":id,"email":email, "full_name":fullname,
      "mobile":phone,"image":_image,"accesstoken":accesstoken,};
  }

  String get type;

}

class User extends StakeHolder{

  Location? location;
  User({super.id,super.fullname,super.phone,super.email,super.image,
    super.accesstoken,this.location,});

  factory User.fromMap(Map map,{String? accesstoken,Location? location,}){
/*
    "latitude": "1651456465",
    "longitude": "64654654",
    "address": "12313132",
    "id": 9,
    "device_token": null,
    "status": 0,
    "is_blocked": 0,
    "otp": null,
    "image": null,*/
    return User(id: map["id"].toString(),email: map["email"],
        fullname: map["full_name"],phone: map["mobile"],image:map["image"],
        accesstoken: accesstoken,location: location);
  }

  factory User.fromLocalMap(Map map){
    return User(id: map["id"],email: map["email"],
        fullname: map["full_name"],phone: map["mobile"],image:map["image"],
        accesstoken: map["accesstoken"],
        location: Location.fromAddressMap(map["location"]));
  }

  @override
  Map<String, dynamic> toLocalMap() {
    return super.toLocalMap()..addAll({"location":location?.toAddressMap()});
  }

  @override
  String get type => StakeHolder.TYPE_USER;

}