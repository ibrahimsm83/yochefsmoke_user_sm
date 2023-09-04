import 'package:ycsh/model/product.dart';

class Order{
  final String? id;
  final List<Product> products;
  String? status;
  double total,subtotal,discount;
  Order({this.id, this.products=const [],this.total=0,this.subtotal=0,
    this.discount=0,this.status,});

  factory Order.fromMap(Map map,{List<Product> products=const []}){
    return Order(id: map["id"].toString(),products: products,
        status: map["status"],
        subtotal: (map["gross_amount"] as num).toDouble(),
      total: (map["net_amount"] as num).toDouble(),
        discount: (map["dis_amount"] as num).toDouble());
  }

}