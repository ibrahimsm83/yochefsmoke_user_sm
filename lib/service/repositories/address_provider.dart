

import 'dart:convert';

import 'package:ycsh/model/address.dart';
import 'package:ycsh/model/user.dart';
import 'package:ycsh/service/network.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/config.dart';

import '../../model/location.dart';

class AddressProvider {

  Future<bool> addDefaultAddress(String token, String address_id,) async {
    bool user_id=false;
    const String url = AppConfig.DIRECTORY + "user/default-address";
    print("addAddress url: $url");

    final Map map = {
      "address_id":address_id,
    };

    final String json = jsonEncode(map);
    print("address map: $json");
    await Network().post(
      url,
      json,
      headers: {'Content-type': 'application/json',"Authorization":"Bearer ${token}",},
      onSuccess: (val) {
        print("addAddress response: $val");
        var map=jsonDecode(val);
        bool status=map["statusCode"]==Network.STATUS_OK;
        user_id=status;
        AppMessage.showMessage(map["message"].toString());
      },
    );
    return user_id;
  }

  Future<bool> addAddress(String token,
      String title,String city,String state,String country,
      String zipcode,{Location? location}) async {
    bool user_id=false;
    const String url = AppConfig.DIRECTORY + "user/create-address";
    print("addAddress url: $url");

    final Map map = {
      "title":title,
      "postal_code":zipcode,
      "city":city,
      "state":state,
      "country":country,
    };

    if(location!=null){
      map.addAll({"latitude": location.latitude,
        "longitude": location.longitude,
        "address": location.name,});
    }

    final String json = jsonEncode(map);

    print("address map: $json");

    await Network().post(
      url,
      json,
      headers: {'Content-type': 'application/json',"Authorization":"Bearer ${token}",},
      onSuccess: (val) {
        print("signup response: $val");
        var map=jsonDecode(val);
        bool status=map["statusCode"]==Network.STATUS_OK;
        user_id=status;
        AppMessage.showMessage(map["message"].toString());
      },
    );
    return user_id;
  }

  Future<Address?> updateAddress(String token,String add_id,
      String title,String city,String state,String country,
      String zipcode,{Location? location}) async {
    Address? user_id;
    const String url = AppConfig.DIRECTORY + "user/update-address";
    print("updateAddress url: $url");

    final Map map = {
      "address_id":add_id,
      "title":title,
      "postal_code":zipcode,
      "city":city,
      "state":state,
      "country":country,
    };

    if(location!=null){
      map.addAll({"latitude": location.latitude,
        "longitude": location.longitude,
        "address": location.name,});
    }

    final String json = jsonEncode(map);

    print("updateAddress map: $json");

    await Network().post(
      url,
      json,
      headers: {'Content-type': 'application/json',"Authorization":"Bearer ${token}",},
      onSuccess: (val) {
        print("address response: $val");
        var map=jsonDecode(val);
        bool status=map["statusCode"]==Network.STATUS_OK;
        if(status) {
          var data=map["data"];
          user_id=Address.fromMap(data,location: Location.fromAddressMap(data));
        }
        AppMessage.showMessage(map["message"].toString());
      },
    );
    return user_id;
  }

  Future<List<Address>?> getAddresses(String token,{Function(Address address)? onTask,}) async{
    List<Address>? users;
    const String url=AppConfig.DIRECTORY+"user/get-profile";
    print("getAddresses url: $url");

    await Network().get(url,headers: {"Authorization":"Bearer ${token}"},
        onSuccess: (val){
          print("getAddresses response: ${val}");
          users = [];
          var map = jsonDecode(val);
          var data=map["data"];
          List list=data["users_addresses"];
          list.forEach((cat) {
            final address=Address.fromMap(cat,location: Location.fromAddressMap(cat));
            users!.add(address);
            onTask?.call(address);
          });
        });
    return users;
  }

  Future<Address?> getDefaultAddress(String token,) async{
    Address? users;
    const String url=AppConfig.DIRECTORY+"user/get-profile";
    print("getDefaultAddress url: $url");

    await Network().get(url,headers: {"Authorization":"Bearer ${token}"},
        onSuccess: (val){
          print("getDefaultAddress response: ${val}");
          var map = jsonDecode(val);
          var data=map["data"];
          List list=data["users_addresses"];
          for(int i=0;i<list.length;i++){
            var cat=list[i];
            final address=Address.fromMap(cat,location: Location.fromAddressMap(cat));
            if(address.isDefault){
              users=address;
              break;
            }
          }
        });
    return users;
  }

}

