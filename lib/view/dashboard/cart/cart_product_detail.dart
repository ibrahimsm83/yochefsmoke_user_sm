import 'package:flutter/material.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/dashboard/home/product_detail.dart';
import 'package:ycsh/widget/button.dart';

class CartProductDetail extends ProductDetailScreen{
  CartProductDetail({required super.product,}):super();

  @override
  State<ProductDetailScreen> createState() {
    return _CartProductDetailState();
  }

}

class _CartProductDetailState extends ProductDetailScreenState{

  @override
  void initState() {
    count=widget.product.quantity;
    widget.product.sidelines.forEach((element) {
      sidelines[element.id!]=element;
    });
    widget.product.varients.forEach((element) {
      varients[element.id!]=element;
    });
    super.initState();
  }

  @override
  Widget buildRow() {
    return CustomButton(text: AppString.TEXT_UPDATE,
      onTap: (){
        cartController.addProductToCart(widget.product, count,
            sidelines: sidelines.values.toList(),checkvars: true,
            varients: varients.values.toList()).then((value) {
          if(value){
            AppNavigator.pop();
            cartController.update();
          }
        });
      },);
  }

}