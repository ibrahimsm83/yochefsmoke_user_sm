import 'package:flutter/material.dart';
import 'package:ycsh/model/address.dart';
import 'package:ycsh/model/product.dart';
import 'package:ycsh/model/user.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/datetime.dart';

class Order{

  static const STATUS_INCART="in_cart",STATUS_PENDING="pending",
      STATUS_RIDER_ASSIGN="rider_assign", STATUS_INROUTE="in_route",
      STATUS_ARRIVED="arrived",STATUS_DELIVERED="delivered",STATUS_COMPLETE="complete",
  STATUS_CANCEL="cancel";

  static const Map<String,Color> colorMap={
    STATUS_PENDING:AppColor.COLOR_GREY2,
    STATUS_RIDER_ASSIGN:AppColor.THEME_COLOR_PRIMARY1,
    STATUS_INROUTE:AppColor.COLOR_BLUE1,
    STATUS_ARRIVED:AppColor.COLOR_BLACK2,
    STATUS_DELIVERED:AppColor.GREEN,
    STATUS_COMPLETE:AppColor.GREEN,
    STATUS_CANCEL:AppColor.COLOR_RED1,
  };

  static const Map<String,String> statusMap={
    STATUS_PENDING:"Pending",
    STATUS_RIDER_ASSIGN:"Assigned",
    STATUS_INROUTE:"In Route",
    STATUS_ARRIVED:"Arrived",
    STATUS_DELIVERED:"Delivered",
    STATUS_COMPLETE:"Complete",
    STATUS_CANCEL:"Cancelled",
  };

  final String? id;
  List<Product> products;
  String status;
  double total,subtotal,discount;
  final String? date;
  final User? user;
  final Rider? rider;
  final Address? address;
  Order({this.id, this.products=const [],this.total=0,this.subtotal=0,this.address,
    this.discount=0,this.status=STATUS_PENDING,this.date,this.user,this.rider,});

  factory Order.fromMap(Map map,{List<Product> products=const [],
    User? user,Rider? rider,Address? address,}){
    String date=DateTimeManager.getFormattedDateTime((map["created_at"] as String)
        .replaceAll("T", " ").replaceAll("Z", ""),isutc: true,
        format: DateTimeManager.dateTimeFormat,format2: DateTimeManager.dateTimeFormat24);
    return Order(id: map["id"].toString(),products: products,
        status: map["status"],date: date,address: address,
        subtotal: (map["gross_amount"] as num).toDouble(),
      total: (map["net_amount"] as num).toDouble(),rider: rider,user: user,
        discount: (map["dis_amount"] as num).toDouble());
  }

}