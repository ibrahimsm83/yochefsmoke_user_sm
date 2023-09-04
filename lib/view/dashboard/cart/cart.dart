import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ycsh/controller/user/cart_controller.dart';
import 'package:ycsh/model/product.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/dashboard/cart/checkout.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/cart_items.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/loader.dart';

class CartScreen extends StatefulWidget {

  final bool back_enabled;
  const CartScreen({Key? key,this.back_enabled=true}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  final CartController cartController=Get.find<CartController>();

  @override
  void initState() {
    cartController.loadCurrentOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double paddLeft= AppSizer.getWidth(AppDimen.DASHBOARD_PADDING_HORZ);
    return CustomBackground(safe: false,
      child: Scaffold(appBar: DashboardAppbar(text: AppString.TEXT_CART,
        leading: widget.back_enabled?ButtonBack(onTap: (){
        AppNavigator.pop();
      },):null,),
        body: GetBuilder<CartController>(
          builder: (cont){
            final order=cont.order;
            return order!=null?(order.products.isNotEmpty?SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom:AppSizer.getHeight(AppDimen.DASHBOARD_NAVIGATION_BAR_HEIGHT)
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Builder(
                    builder: (context) {
                      List<Product> list=order.products;
                      return ListView.separated(shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.fromLTRB(
                            paddLeft,0,paddLeft,0,
                          ),
                          itemBuilder: (con,ind){
                            var item=list[ind];
                            return CartItemContainer(product: item,
                              onDelete: (){
                                cartController.deleteProduct(item);
                              },
                              onTap: (val){
                              int c=item.quantity+val;
                              if(c>=1) {
                                cartController.addProductToCart(item, c).then((value) {
                                  if(value){
                                    item.quantity=c;
                                    cartController.update();
                                  }
                                });
                              }
                            },);
                          }, separatorBuilder: (con,ind){
                            return SizedBox(height: AppSizer.getHeight(15),);
                          }, itemCount: list.length);
                    }
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: paddLeft),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        buildPrice(AppString.TEXT_SUBTOTAL, order.subtotal),
                        const DottedContainer(),
                        buildPrice(AppString.TEXT_TOTAL, order.total),
                        SizedBox(height: AppSizer.getHeight(20),),
                        CustomButton(text:AppString.TEXT_CHECKOUT,onTap: (){
                          AppNavigator.navigateTo(CheckOutScreen());
                        },)
                      ],),),

                ],
              ),
            )
                :const NotFoundText()):const ContentLoading();
          },
        ),),
    );
  }

  Widget buildPrice(String text,double price){
    const double fontsize=AppDimen.FONT_CART_HEADING;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizer.getHeight(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        CustomText(text: text,fontsize: fontsize,fontweight: FontWeight.w600,),
        CustomText(text: "\$${price}",fontsize: fontsize,fontweight: FontWeight.bold,),
      ],),
    );
  }
}
