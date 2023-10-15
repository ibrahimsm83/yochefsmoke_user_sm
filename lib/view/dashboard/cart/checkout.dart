import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ycsh/controller/user/controllers.dart';
import 'package:ycsh/model/payment.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/dashboard/address/address.dart';
import 'package:ycsh/view/dashboard/cart/review.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/cart_items.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/loader.dart';
import 'package:ycsh/widget/payment_items.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {

  //int selected=0;

  CreditCard? selectedCard;

  final ProfileController addressController=Get.find<ProfileController>();
  final PaymentController paymentController=Get.find<PaymentController>();

  final CartController cartController=Get.find<CartController>();

  @override
  void initState() {
    addressController.loadDefaultAddresses();
    paymentController.loadDefaultCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double spacing=AppSizer.getHeight(20);
    final double spacing2=AppSizer.getHeight(10);
    var order=cartController.order!;
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
        buildFieldValue(AppString.TEXT_ADDRESS,
            GetBuilder<ProfileController>(
              builder: (cont) {
                var address=cont.defaultAddress;
                return address!=null?AddressContainer(address: address,onTap: (){
                  AppNavigator.navigateTo(AddressScreen());
                },) :const ContentLoading();
              }
            )
        ),
          SizedBox(height: spacing,),
          buildFieldValue(AppString.TEXT_PAYMENT_METHOD,Column(
           // shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
            children: [
              GetBuilder<PaymentController>(
                builder: (cont) {
                  final card=cont.defaultCard;
                  return card!=null?(card.id!=null?Padding(
                    padding: EdgeInsets.only(bottom: spacing2),
                    child: PaymentContainer(icon: AssetPath.IMAGE_MASTERCARD,
                      text1: card.type!,text2: card.maskedNumber,
                      selected: selectedCard!=null,onTap: (){
                      setState(() {
                       // selected=0;
                        selectedCard=card;
                      });
                    },),
                  ):Container()):Padding(
                    padding: EdgeInsets.only(bottom: spacing2),
                    child: const ContentLoading(),
                  );
                }
              ),
              PaymentContainer(icon: AssetPath.ICON_CASH_DELIVERY,
                text1: AppString.TEXT_CASH_ON_DELIVERY,
                selected: selectedCard==null,onTap: (){
                setState(() {
                 // selected=1;
                  selectedCard=null;
                });
              },),
          ],)),
         // SizedBox(height: spacing,),
          SizedBox(height: AppSizer.getHeight(40),),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildPrice(AppString.TEXT_SUBTOTAL, order.subtotal),
              const DottedContainer(),
              buildPrice(AppString.TEXT_TOTAL, order.total),

            ],),
          SizedBox(height: AppSizer.getHeight(30),),
/*          AddVoucherButton(onTap: (){

          },),
          SizedBox(height: AppSizer.getHeight(24),),*/
          CustomButton(text:AppString.TEXT_PLACE_ORDER,onTap: (){
            cartController.postOrder(addressController.defaultAddress,card: selectedCard,);
          //  AppNavigator.navigateTo(ReviewScreen());
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
