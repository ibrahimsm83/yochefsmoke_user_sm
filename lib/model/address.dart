import 'package:ycsh/model/location.dart';

class Address{
  final String? id;
  String? title,city,state,country,postal_code;
  Location? location;
  final bool isDefault;

  Address({this.id, this.title, this.city, this.state, this.country,this.isDefault=false,
      this.postal_code, this.location});

  factory Address.fromMap(Map map,{Location? location}){
    return Address(id: map["id"].toString(),title: map["title"],postal_code: map["postal_code"],
        city: map["city"],state: map["state"],country: map["country"],
        isDefault: map["is_default"]==1,
        location: location);
  }

}