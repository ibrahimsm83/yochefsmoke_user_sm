import 'package:ycsh/model/product.dart';
import 'package:ycsh/utils/datetime.dart';

class Stock{
  final String? id,binding_id,order_id;
  final Product? product;
  final int quantity;
  final String? date;
  const Stock({this.id, this.binding_id,this.product,this.quantity=0,
    this.order_id,this.date,});

  factory Stock.fromMap(Map map,{Product? product}){
    String date=DateTimeManager.getFormattedDateTime((map["created_at"] as String)
        .replaceAll("T", " ").replaceAll("Z", ""),isutc: true,
        format: DateTimeManager.dateTimeFormat,format2: DateTimeManager.dateTimeFormat24);
    return Stock(id: map["id"].toString(),date: date,
        binding_id: map["binding_id"],order_id: map["order_id"].toString(),
        quantity: map["quantity"],product: product);
  }

}