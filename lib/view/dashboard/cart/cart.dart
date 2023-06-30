import 'package:flutter/material.dart';
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

class CartScreen extends StatefulWidget {

  final bool back_enabled;
  const CartScreen({Key? key,this.back_enabled=true}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final double paddLeft= AppSizer.getWidth(AppDimen.DASHBOARD_PADDING_HORZ);
    return CustomBackground(safe: false,
      child: Scaffold(appBar: DashboardAppbar(text: AppString.TEXT_CART,
        leading: widget.back_enabled?ButtonBack(onTap: (){
        AppNavigator.pop();
      },):null,),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
              bottom:AppSizer.getHeight(AppDimen.DASHBOARD_NAVIGATION_BAR_HEIGHT)
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListView.separated(shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                      paddLeft,0,paddLeft,0,
                  ),
                  itemBuilder: (con,ind){
                return CartItemContainer();
              }, separatorBuilder: (con,ind){
                return SizedBox(height: AppSizer.getHeight(15),);
      }, itemCount: 3),
              Padding(padding: EdgeInsets.symmetric(horizontal: paddLeft),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  buildPrice(AppString.TEXT_SUBTOTAL, 80),
                  DottedContainer(),
                  buildPrice(AppString.TEXT_TOTAL, 80),
                  SizedBox(height: AppSizer.getHeight(20),),
                  CustomButton(text:AppString.TEXT_CHECKOUT,onTap: (){
                    AppNavigator.navigateTo(CheckOutScreen());
                  },)
              ],),),

            ],
          ),
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
