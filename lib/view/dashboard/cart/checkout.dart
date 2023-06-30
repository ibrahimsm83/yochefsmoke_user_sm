import 'package:flutter/material.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/dashboard/cart/review.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/cart_items.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/payment_items.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {

  int selected=0;

  @override
  Widget build(BuildContext context) {
    final double spacing=AppSizer.getHeight(20);
    return CustomBackground(child: Scaffold(
      appBar: DashboardAppbar(text:AppString.TEXT_PAYMENT,
      leading: ButtonBack(onTap: (){
        AppNavigator.pop();
      },
      ),),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizer.getWidth(AppDimen.DASHBOARD_PADDING_HORZ),
          vertical: AppDimen.SCROLL_OFFSET_PADDING_VERT,
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        buildFieldValue(AppString.TEXT_ADDRESS,AddressContainer()),
          SizedBox(height: spacing,),
          buildFieldValue(AppString.TEXT_PAYMENT_METHOD,ListView(
            shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
            children: [
              PaymentContainer(icon: AssetPath.IMAGE_MASTERCARD,
                text1: "MasterCard",text2: "**********2678",
                selected: selected==0,onTap: (){
                setState(() {
                  selected=0;
                });
              },),
              SizedBox(height: AppSizer.getHeight(10),),
              PaymentContainer(icon: AssetPath.ICON_CASH_DELIVERY,
                text1: AppString.TEXT_CASH_ON_DELIVERY,
                selected: selected==1,onTap: (){
                setState(() {
                  selected=1;
                });
              },),
          ],)),
         // SizedBox(height: spacing,),
          SizedBox(height: AppSizer.getHeight(40),),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildPrice(AppString.TEXT_SUBTOTAL, 80),
              DottedContainer(),
              buildPrice(AppString.TEXT_TOTAL, 80),

            ],),
          SizedBox(height: AppSizer.getHeight(30),),
          AddVoucherButton(onTap: (){

          },),
          SizedBox(height: AppSizer.getHeight(24),),
          CustomButton(text:AppString.TEXT_PLACE_ORDER,onTap: (){
            AppNavigator.navigateTo(ReviewScreen());
          },)

      ],),),
    ));
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

  Widget buildFieldValue(String field,Widget value){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      buildHeading(field),
      SizedBox(height: AppSizer.getHeight(23),),
      value,
    ],);
  }

  Widget buildHeading(String text){
    return CustomText(text: text,fontsize: AppDimen.FONT_CART_HEADING,
      fontweight: FontWeight.w600,);
  }
}
