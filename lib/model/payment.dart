import 'dart:convert';

class CreditCard{
  final String? id;
  final String? number,exp_month,exp_year,cvc,name,type;
  final bool isDefault;
  CreditCard({this.id,this.number, this.exp_month, this.exp_year, this.cvc,this.name,
    this.type, this.isDefault=false,});


  factory CreditCard.fromMap(Map map){
    var map2=jsonDecode(map["card_detail"]);
    print("map 2 is: $map2");
    List<String> list=map2["expire"].split("/");
    return CreditCard(id:map["id"].toString(),type: map["type"],
        exp_month: list[0],isDefault: map["default_card"]==1,
        exp_year: list[1],
        cvc: map2["cvc"],
        number: map2["card_number"]);
  }

  String get maskedNumber{
    //return number!.replaceRange(0, number!.length-4, "${for(int i=0;i<4;i++)print("*")}");
    return "************"+number!.substring(number!.length-4,number!.length);
  }

}