
import 'dart:convert';

import 'package:ycsh/model/payment.dart';
import 'package:ycsh/service/network.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/config.dart';

class PaymentProvider {

  Future<bool> addDefaultCard(String token, String card_id,) async {
    bool user_id=false;
    const String url = AppConfig.DIRECTORY + "user/set-default-card";
    print("addAddress url: $url");

    final Map map = {
      "card_id":card_id,
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

  Future<bool> addCard(String token, String card_num,String exp_month,String exp_year,
      String cvv,) async {
    bool user_id=false;
    const String url = AppConfig.DIRECTORY + "user/create-card";
    print("addCard url: $url");

    final Map map = {
      "type":"das",
      "card_number":card_num,
      "expire":"$exp_month/$exp_year",
      "cvc":cvv,
    };

    final String json = jsonEncode(map);

    print("card map: $json");

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

  Future<bool> deleteCard(String token,String card_id,) async {
    bool order=false;
    const String url = AppConfig.DIRECTORY + "user/delete-card";
    print("deleteCard url: $url");

    final Map map = {
      "card_id":card_id,
    };

    final String json = jsonEncode(map);

    print("deleteCard map: $json");

    await Network().post(
      url,
      json,
      headers: {'Content-type': 'application/json',"Authorization":"Bearer ${token}",},
      onSuccess: (val) {
        print("postOrder response: $val");
        var map=jsonDecode(val);
        bool status=map["statusCode"]==Network.STATUS_OK;
        order=status;
        // order=status;
        AppMessage.showMessage(map["message"].toString());
      },
    );
    return order;
  }

  Future<List<CreditCard>?> getCards(String token,{Function(CreditCard address)? onTask,}) async{
    List<CreditCard>? users;
    const String url=AppConfig.DIRECTORY+"user/get-all-cards";
    print("getCards url: $url");

    await Network().get(url,headers: {"Authorization":"Bearer ${token}"},
        onSuccess: (val){
          print("getCards response: ${val}");
          users = [];
          var map = jsonDecode(val);
          var data=map["data"];
          List list=data;
          list.forEach((cat) {
            try {
              final address = CreditCard.fromMap(cat,);
              users!.add(address);
              onTask?.call(address);
            }
            catch(ex){

            }
          });
        });
    return users;
  }

  Future<CreditCard?> getDefaultCard(String token,) async{
    CreditCard? users;
    const String url=AppConfig.DIRECTORY+"user/get-all-cards";
    print("getDefaultCard url: $url");

    await Network().get(url,headers: {"Authorization":"Bearer ${token}"},
        onSuccess: (val){
          print("getDefaultCard response: ${val}");
          var map = jsonDecode(val);
          var data=map["data"];
          List list=data;
          for(int i=0;i<list.length;i++){
            try {
              var cat = list[i];
              final address = CreditCard.fromMap(cat,);
              if (address.isDefault) {
                users = address;
                break;
              }
            }
            catch(ex){

            }
          }
        });
    return users;
  }
}

