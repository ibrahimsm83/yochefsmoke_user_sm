import 'package:ycsh/model/address.dart';
import 'package:ycsh/model/location.dart';
import 'package:ycsh/utils/config.dart';

abstract class StakeHolder{

  static const TYPE_USER="user",TYPE_RIDER="rider";

  final String? id;
  final String? email;
  String? fullname,phone,_image,role;
  final String? accesstoken;

  StakeHolder({this.id, this.email, this.fullname, this.phone,String?image,
    this.role,
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
      "mobile":phone,"image":_image,
      "role":role,
      "accesstoken":accesstoken,};
  }

  String get type;

}

class User extends StakeHolder{

//  Location? location;
  Address? address;
  User({super.id,super.fullname,super.phone,super.email,super.image,super.role,
    super.accesstoken,this.address,});

  factory User.fromMap(Map map,{String? accesstoken,Address? location,}){
    return User(id: map["id"].toString(),email: map["email"],
        fullname: map["full_name"],phone: map["mobile"],image:map["image"],
        role: map['role'],
        accesstoken: accesstoken,address: location);
  }

  factory User.fromLocalMap(Map map){
    return User(id: map["id"],email: map["email"],
        fullname: map["full_name"],phone: map["mobile"],image:map["image"],
        role: map['role'],
        accesstoken: map["accesstoken"],
        address: Address.fromHome(Location.fromAddressMap(map["location"])));
  }

  @override
  Map<String, dynamic> toLocalMap() {
    return super.toLocalMap()..addAll({"location":address?.location?.toAddressMap()});
  }

  @override
  String get type => StakeHolder.TYPE_USER;

}

class Rider extends StakeHolder {
  Rider({
    super.id,
    super.fullname,
    super.phone,
    super.email,
    super.image,
    super.role,
    super.accesstoken,
  });

  factory Rider.fromMap(
      Map map, {
        String? accesstoken,
      }) {
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
    return Rider(
      id: map["id"].toString(),
      email: map["email"],
      fullname: map["full_name"],
      phone: map["mobile"],
      image: map["image"],
      role: map['role'],
      accesstoken: accesstoken,
    );
  }

  factory Rider.fromLocalMap(Map map) {
    return Rider(
      id: map["id"],
      email: map["email"],
      fullname: map["full_name"],
      phone: map["mobile"],
      image: map["image"],
      role: map['role'],
      accesstoken: map["accesstoken"],
    );
  }

  @override
  Map<String, dynamic> toLocalMap() {
    return super.toLocalMap()..addAll({});
  }

  @override
  String get type => StakeHolder.TYPE_RIDER;
}