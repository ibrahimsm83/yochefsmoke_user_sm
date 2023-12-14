import 'dart:convert';

import 'package:ycsh/model/page_model.dart';
import 'package:ycsh/model/product.dart';
import 'package:ycsh/service/network.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/config.dart';
import 'package:ycsh/utils/constants.dart';

class ProductProvider{


  Future<List<FoodCategory>?> getAllFoodCategories(String token,) async{
    List<FoodCategory>? users;
    const String url=AppConfig.DIRECTORY+"meals-type/all";
    print("getAllFoodCategories url: $url");

    await Network().get(url,headers: {"Authorization":"Bearer ${token}"},
        onSuccess: (val){
          print("getAllFoodCategories response: ${val}");
          users = [];
          var map = jsonDecode(val);
          var data=map["data"];
          List list=data;
          list.forEach((cat) {
            users!.add(FoodCategory.fromMap(cat));
          });
    });
    return users;
  }

/*
  Future<List<Product>?> getCategoryProducts(String token,{String? cat_id,}) async{
    List<Product>? users;
    const String url=AppConfig.DIRECTORY+"products/all";
    print("getCategoryProducts url: $url");

    final Map map={};
    if(cat_id!=null){
      map["meals_type_id"]=cat_id;
    }
    final String body=jsonEncode(map);

    await Network().post(url,body,headers: {"Authorization":"Bearer ${token}",
      'Content-type': 'application/json'},
        onSuccess: (val){
          print("getAllFoodCategories response: ${val}");
          users = [];
          var map = jsonDecode(val);
          var data=map["data"];
          List list=data["results"];
          list.forEach((cat) {
            users!.add(Product.fromMap(cat,
                sidelines: (cat["product_sidelines"] as List).map((e) {
                  return ProductSideline.fromMap(e);
                }).toList()));
          });
        });
    return users;
  }
*/


  Future<PageModel<Product>?> getProducts(String token,{String? cat_id,int page=1,
    int limit=AppInteger.PAGE_LIMIT,String search="",bool isFavourite=false}) async{
    PageModel<Product>? users;
    final String url=AppConfig.DIRECTORY+"products/all?page=$page&limit=$limit";
    print("getProducts url: $url");

    final Map map={"search_text":search,"is_favorite":isFavourite?1:0};
    if(cat_id!=null){
      map["meals_type_id"]=cat_id;
    }
    final String body=jsonEncode(map);
    print("getCategoryProducts body: $body");
    await Network().post(url,body,headers: {"Authorization":"Bearer ${token}",
      'Content-type': 'application/json'},
        onSuccess: (val){
          print("getProducts response: ${val}");
          var map = jsonDecode(val);
          var data=map["data"];
          List list=data["results"];
          var meta=data["meta"];
          users=PageModel(data: list.map<Product>((cat) {
            print("prod id: ${cat["id"]}");
            return Product.fromMap(cat,
                sidelines: (cat["product_sidelines"] as List).map((e) {
                  return ProductSideline.fromMap(e,name: e["product"]["name"]);
                }).toList(),
                varients: (cat["variant"] as List).map((e) {
                  return ProductVariant.fromMap(e,);
                }).toList());
          }).toList(), total_page: meta["totalPages"]);
        });
    return users;
  }

  Future<bool> addFavouriteProduct(String token,String prod_id) async {
    bool user=false;
    const String url = AppConfig.DIRECTORY + "products/favorite-product-add-remove";
    print("addFaouriteProduct url: $url");
    final String map = jsonEncode({"product_id": prod_id,});
    await Network().post(
      url,
      map,
      headers: {"Authorization":"Bearer ${token}",
        'Content-type': 'application/json'},
      onSuccess: (val) {
        print("addFaouriteProduct response: $val");
        var map=jsonDecode(val);
        bool status=map["statusCode"]==Network.STATUS_OK;
        user=status;
        AppMessage.showMessage(map["message"].toString());
      },
    );
    return user;
  }

  Future<Product?> getProductDetail(String token,String id) async{
    Product? product;
    String url=AppConfig.DIRECTORY+"products/detail-product/$id";
    print("getProductDetail url: $url");

    await Network().get(url,headers: {"Authorization":"Bearer ${token}"},
        onSuccess: (val){
          print("getProductDetail response: ${val}");
          var map = jsonDecode(val);
          if(map["statusCode"]==Network.STATUS_OK) {
            var data = map["data"];
            product = Product.fromMap(data,
                sidelines: (data["product_sidelines"] as List).map((e) {
              return ProductSideline.fromMap(e,name: e["product"]["name"]);
            }).toList(),
                varients: (data["variant"] as List).map((e) {
              return ProductVariant.fromMap(e,);
            }).toList());
          }
        });
    return product;
  }
}