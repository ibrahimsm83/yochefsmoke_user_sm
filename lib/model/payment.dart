import 'dart:convert';

class CreditCard{
  final String? id,card_id;
  final String? number,exp_month,exp_year,cvc,name,type;
  final bool isDefault;
  CreditCard({this.id,this.card_id,this.number, this.exp_month, this.exp_year, this.cvc,this.name,
    this.type, this.isDefault=false,});


  factory CreditCard.fromMap(Map map){
    var map2=jsonDecode(map["card_details"]);
    return CreditCard(id:map["id"].toString(),card_id:map2["id"].toString(),
        type: map2["brand"],
        exp_month: map2["exp_month"].toString(),isDefault: map["default_card"]==1,
        exp_year: map2["exp_year"].toString(),
        number: map2["last4"]);
  }

  String get maskedNumber{
    return "************"+number!.substring(number!.length-4,number!.length);
  }

}