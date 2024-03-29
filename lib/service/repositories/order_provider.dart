import 'dart:convert';

import 'package:ycsh/model/address.dart';
import 'package:ycsh/model/location.dart';
import 'package:ycsh/model/order.dart';
import 'package:ycsh/model/page_model.dart';
import 'package:ycsh/model/product.dart';
import 'package:ycsh/model/stock.dart';
import 'package:ycsh/model/user.dart';
import 'package:ycsh/service/network.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/config.dart';
import 'package:ycsh/utils/constants.dart';

class OrderProvider{

  Future<Order?> addToCart(String token,Product product,int quantity,
      {List<ProductSideline> sidelines=const [], List<ProductVariant>
      varients=const []}) async {
    //bool order=false;
    Order? order;
    const String url = AppConfig.DIRECTORY + "orders/product-add-update-in-cart";
    print("addToCart url: $url");

    final Map<String,String> map = {
      "cooked_type":product.cook_type!,
      "quantity":quantity.toString(),
      "product_id":product.id!,
    };

    for(int i=0;i<sidelines.length;i++){
      var item=sidelines[i];
      map["product_sideline[$i][product_sidelines_id]"]=item.id!;
      map["product_sideline[$i][quantity]"]=item.quantity.toString();
    }

    for(int i=0;i<varients.length;i++){
      var item=varients[i];
      map["variants_item[$i][variants_item_id]"]=item.id!;
      map["variants_item[$i][quantity]"]=item.quantity.toString();
    }

    //final String json = jsonEncode(map);

    print("addToCart map: $map");

    await Network().multipartPost(
      url,
      map,
      headers: {'Content-type': 'application/json',"Authorization":"Bearer ${token}",},
      onSuccess: (val) {
        print("addToCart response: $val");
        var map=jsonDecode(val);
        bool status=map["statusCode"]==Network.STATUS_OK;
        var data = map["data"];
        List list = data["product_item"];
        order = Order.fromMap(data,
            products: list.map<Product>((cat) {
              var prod = cat["product"];
              return Product.fromMap(prod, quantity: cat["quantity"],
                detail_id:cat["id"].toString(),
                varients: (cat["product_variant"] as List).map((e) {
                  var map=e["product_variant_price"];
                  return ProductVariant.fromMap(map,quantity: e["quantity"]);
                }).toList(),
                sidelines: (cat["product_sideline"] as List).map((e) {
                  var map=e["product_sideline_price"];
                  return ProductSideline.fromMap(map,
                      quantity: e["quantity"],
                      name: e["sideline"]["name"]);
                }).toList(),
              );
            }).toList());
        //order=status;
        AppMessage.showMessage(map["message"].toString());
      },
    );
    return order;
  }

  Future<Order?> deleteProduct(String token,String order_id,String prod_id,) async {
    Order? order;
    const String url = AppConfig.DIRECTORY + "orders/product-remove-in-cart";
    print("deleteProduct url: $url");

    final Map map = {
      "order_detail_id":prod_id,
      "order_id":order_id,
    };

    final String json = jsonEncode(map);

    print("deleteProduct map: $json");

    await Network().post(
      url,
      json,
      headers: {'Content-type': 'application/json',"Authorization":"Bearer ${token}",},
      onSuccess: (val) {
        print("postOrder response: $val");
        var map=jsonDecode(val);
        bool status=map["statusCode"]==Network.STATUS_OK;
        var data = map["data"];
        List list = data["product_item"];
        order = Order.fromMap(data,
            products: list.map<Product>((cat) {
              var prod = cat["product"];
              return Product.fromMap(prod, quantity: cat["quantity"],
                detail_id:cat["id"].toString(),
                varients: (cat["product_variant"] as List).map((e) {
                  var map=e["product_variant_price"];
                  return ProductVariant.fromMap(map,quantity: e["quantity"]);
                }).toList(),
                sidelines: (cat["product_sideline"] as List).map((e) {
                  var map=e["product_sideline_price"];
                  return ProductSideline.fromMap(map,
                      quantity: e["quantity"],
                      name: e["sideline"]["name"]);
                }).toList(),
              );
            }).toList());
        // order=status;
        AppMessage.showMessage(map["message"].toString());
      },
    );
    return order;
  }

  Future<Order?> getCurrentOrder(String token,) async{
    Order? order;
    const String url=AppConfig.DIRECTORY+"orders/current-order";
    print("getCurrentOrder url: $url");

    await Network().get(url,headers: {"Authorization":"Bearer ${token}"},
        onSuccess: (val){
          print("getCurrentOrder response: ${val}");
          var map = jsonDecode(val);
          if(map["statusCode"]==Network.STATUS_OK) {
            var data = map["data"];
            List list = data["product_item"];
            order = Order.fromMap(data,
                products: list.map<Product>((cat) {
                  var prod = cat["product"];
                  return Product.fromMap(prod, quantity: cat["quantity"],
                    detail_id:cat["id"].toString(),
                    varients: (cat["product_variant"] as List).map((e) {
                      var map=e["product_variant_price"];
                      return ProductVariant.fromMap(map,quantity: e["quantity"]);
                    }).toList(),
                      sidelines: (cat["product_sideline"] as List).map((e) {
                        var map=e["product_sideline_price"];
                        return ProductSideline.fromMap(map,
                            quantity: e["quantity"],
                            name: e["sideline"]["name"]);
                      }).toList(),
                  );
                }).toList());
          }
          else{
            order=Order();
          }
        });
    return order;
  }

  Future<bool> postOrder(String token,String order_id,String? add_id,
      {String? card_id}) async {
    bool user_id=false;
    const String url = AppConfig.DIRECTORY + "orders/order-submit";
    print("postOrder url: $url");

    final Map map = {
      "order_id":order_id,
      "note":"",
    };
    if(add_id!=null){
      map["address_id"]= add_id;
    }
    if(card_id!=null){
      map["card_id"]=card_id;
    }

    final String json = jsonEncode(map);

    print("postOrder map: $json");

    await Network().post(
      url,
      json,
      headers: {'Content-type': 'application/json',"Authorization":"Bearer ${token}",},
      onSuccess: (val) {
        print("postOrder response: $val");
        var map=jsonDecode(val);
        bool status=map["statusCode"]==Network.STATUS_OK;
        user_id=status;
        AppMessage.showMessage(map["message"].toString());
      },
    );
    return user_id;
  }

  Future<PageModel<Order>?> getOrderHistory(String token,{int page=1,
    int limit=AppInteger.PAGE_LIMIT,}) async{
    PageModel<Order>? users;
    final String url=AppConfig.DIRECTORY+"orders/order-history?page=$page&limit=$limit";
    print("getOrderHistory url: $url");

    await Network().get(url,headers: {"Authorization":"Bearer ${token}",
      'Content-type': 'application/json'},
        onSuccess: (val){
          print("getOrderHistory response: ${val}");
          var map = jsonDecode(val);
          var data=map["data"];
          List list=data["results"];
          var meta=data["meta"];
          users=PageModel(data: list.map<Order>((cat) {
            List list = cat["product_item"];
            var address=cat["address"];
            return Order.fromMap(cat,
                user: User.fromMap(cat["user"]),
                rider: cat["rider"]!=null?Rider.fromMap(cat["rider"]):null,
                address: address!=null?Address.fromMap(address,
                    location: Location.fromAddressMap(address)):null,
                products: list.map<Product>((cat) {
                  var prod = cat["product"];
                  return Product.fromMap(prod, quantity: cat["quantity"],
                    detail_id:cat["id"].toString(),
                    varients: (cat["product_variant"] as List).map((e) {
                      var map=e["product_variant_price"];
                      return ProductVariant.fromMap(map,quantity: e["quantity"]);
                    }).toList(),
                    sidelines: (cat["product_sideline"] as List).map((e) {
                      var map=e["product_sideline_price"];
                      return ProductSideline.fromMap(map,
                          quantity: e["quantity"],
                          name: e["sideline"]["name"]);
                    }).toList(),
                  );
                }).toList());
          }).toList(), total_page: meta["totalPages"],total_items: meta["totalItems"]);
        });
    return users;
  }

  Future<PageModel<Order>?> getActiveOrders(String token,{int page=1,
    int limit=AppInteger.PAGE_LIMIT,}) async{
    PageModel<Order>? users;
    final String url=AppConfig.DIRECTORY+"orders/user-current-orders?page=$page&limit=$limit";
    print("getActiveOrders url: $url");

    await Network().get(url,headers: {"Authorization":"Bearer ${token}",
      'Content-type': 'application/json'},
        onSuccess: (val){
          print("getActiveOrders response: ${val}");
          var map = jsonDecode(val);
          var data=map["data"];
          List list=data["results"];
          var meta=data["meta"];
          users=PageModel(data: list.map<Order>((cat) {
            List list = cat["product_item"];
            var address=cat["address"];
            print("ord id: ${cat["id"]}");
            return Order.fromMap(cat,
                user: User.fromMap(cat["user"]),
                rider: cat["rider"]!=null?Rider.fromMap(cat["rider"]):null,
                address: address!=null?Address.fromMap(address,
                    location: Location.fromAddressMap(address)):null,
                products: list.map<Product>((cat) {
                  var prod = cat["product"];
                  print("prod id: ${cat["product_variant"]}");

                  return Product.fromMap(prod, quantity: cat["quantity"],
                    detail_id:cat["id"].toString(),
                    varients: (cat["product_variant"] as List).map((e) {
                      var map=e["product_variant_price"];
                      return ProductVariant.fromMap(map,quantity: e["quantity"]);
                    }).toList(),
                    sidelines: (cat["product_sideline"] as List).map((e) {
                      var map=e["product_sideline_price"];
                      return ProductSideline.fromMap(map,
                          quantity: e["quantity"],
                          name: e["sideline"]["name"]);
                    }).toList(),
                  );
                }).toList());
          }).toList(), total_page: meta["totalPages"]);
        });
    return users;
  }

  Future<Order?> getOrderDetails(String token,String order_id,) async{
    Order? order;
    final String url=AppConfig.DIRECTORY+"orders/order-detail/$order_id";
    print("getOrderDetails url: $url");

    await Network().get(url,headers: {"Authorization":"Bearer ${token}",
      'Content-type': 'application/json'},
        onSuccess: (val){
          print("getOrderDetails response: ${val}");
          var map = jsonDecode(val);
          if(map["statusCode"]==Network.STATUS_OK) {
            var cat = map["data"];
            List list = cat["product_item"];
            var address=cat["address"];
            order=Order.fromMap(cat,
                user: User.fromMap(cat["user"]),
                rider: cat["rider"]!=null?Rider.fromMap(cat["rider"]):null,
                address: address!=null?Address.fromMap(address,
                    location: Location.fromAddressMap(address)):null,
                products: list.map<Product>((cat) {
                  var prod = cat["product"];
                  print("prod id: ${cat["product_variant"]}");

                  return Product.fromMap(prod, quantity: cat["quantity"],
                    detail_id:cat["id"].toString(),
                    varients: (cat["product_variant"] as List).map((e) {
                      var map=e["product_variant_price"];
                      return ProductVariant.fromMap(map,quantity: e["quantity"]);
                    }).toList(),
                    sidelines: (cat["product_sideline"] as List).map((e) {
                      var map=e["product_sideline_price"];
                      return ProductSideline.fromMap(map,
                          quantity: e["quantity"],
                          name: e["sideline"]["name"]);
                    }).toList(),
                  );
                }).toList());
          }
        });
    return order;
  }

  Future<PageModel<Stock>?> getRiderStocks(String token,String binding_id,{int page=1,
    int limit=AppInteger.PAGE_LIMIT,}) async{
    PageModel<Stock>? users;
    final String url=AppConfig.DIRECTORY+"orders/rider-stock/binding?"
        "page=$page&limit=$limit";
    print("getCurrentStocks url: $url");

    final map=jsonEncode({"binding_id":binding_id});

    await Network().post(url,map,
        headers: {"Authorization":"Bearer ${token}",
      'Content-type': 'application/json'},
        onSuccess: (val){
          print("getCurrentStocks response: ${val}");
          var map = jsonDecode(val);
          var data=map["data"];
          List list=data["results"];
          var meta=data["meta"];
          users=PageModel(data: list.map<Stock>((cat) {
            return Stock.fromMap(cat,product: Product.fromMap(cat["product"]));
          }).toList(), total_page: meta["totalPages"],total_items: meta["totalItems"]);
        });
    return users;
  }

}