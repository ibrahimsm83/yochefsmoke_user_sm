import 'package:ycsh/model/interface.dart';
import 'package:ycsh/utils/config.dart';

class FoodCategory{
  final String? id,name;
  String? _image;
  FoodCategory({this.id, this.name, String? image,}){
    _image=image;
  }

  String get image => AppConfig.IMAGE_URL+(_image??"");

  factory FoodCategory.fromMap(Map map,){
    return FoodCategory(id:map["id"].toString(),name: map["name"],image: map["image"]);
  }
}

class Product{
  final String? id,detail_id;
  final String? name,description,cook_type;
  final FoodCategory? category;
  String? _image;
  final double? price;
  final int cur_quantity;
  int quantity;
  final List<ProductSideline> sidelines;
  final List<ProductVariant> varients;
  bool isFavourite;
  Product({this.id, this.name, this.description, this.category,this.quantity=0,
    this.cur_quantity=0,
    this.isFavourite=false,this.detail_id,
    this.price,this.cook_type,this.sidelines= const[],this.varients=const [],
    String? image,}){
    _image=image;
  }

  factory Product.fromMap(Map map,{List<ProductSideline> sidelines=const [],
    List<ProductVariant> varients=const [],int quantity=0,String? detail_id,}){
    return Product(id:map["id"].toString(),name: map["name"],image: map["image"],
        description: map["description"],price: (map["price"] as num).toDouble(),
    isFavourite: (map["is_favorite_product"]?["is_favorite_product"]==1),
    cur_quantity: map["current_qty"],quantity: quantity,detail_id: detail_id,
        cook_type: map["cook_type"],sidelines: sidelines,
        varients: varients);
  }

  String get image => AppConfig.IMAGE_URL+(_image??"");
}

class ProductSideline with DropDownItem{
  final String? id,name;
  final double? price;
  int quantity;
  ProductSideline({this.id,this.price,this.name,this.quantity=0,});

  factory ProductSideline.fromMap(Map map,{String? name,int quantity=0}){
    return ProductSideline(id:map["id"].toString(),quantity: quantity,
        price: (map["price"] as num).toDouble(),name: name);
  }

  @override
  String getId() {
    return id!;
  }

  @override
  String getText() {
    return "$name \$$price";
  }

}

class ProductVariant with DropDownItem{
  final String? id,name,value;
  final double? price;
  int quantity;
  ProductVariant({this.id,this.price,this.name,this.value,this.quantity=0,});

  factory ProductVariant.fromMap(Map map,{int quantity=0}){
    return ProductVariant(id:map["id"].toString(),
        price: (map["price"] as num).toDouble(),quantity: quantity,
        name: map["attribute"]["name"],value: map["attribute_value"]["value"]);
  }

  @override
  String getId() {
    return id!;
  }

  @override
  String getText() {
    return "$name: $value \$$price";
  }

}