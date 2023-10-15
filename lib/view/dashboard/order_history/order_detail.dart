import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ycsh/controller/user/controllers.dart';
import 'package:ycsh/model/order.dart';
import 'package:ycsh/model/product.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/dashboard/track_order/track_order.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/loader.dart';

class OrderDetailScreen extends StatefulWidget {

  final Order order;
  final bool load;
  const OrderDetailScreen({Key? key,required this.order,this.load=false,}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {

  final OrderController orderController=Get.find<OrderController>();

  Order? order;

  @override
  void initState() {
    if(widget.load){
      orderController.loadOrderDetails(widget.order.id!).then((value){
        if(value!=null){
          order=value;
          orderController.update();
        }
      });
    }
    else{
      order=widget.order;
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final double paddHorz=AppSizer.getHeight(AppDimen.DASHBOARD_PADDING_HORZ);
    return CustomBackground(child: Scaffold(
      appBar: DashboardAppbar(
        leading: ButtonBack(onTap: (){
          AppNavigator.pop();
        },),),
      body: GetBuilder<OrderController>(
        builder: (context) {
          return order!=null?SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: paddHorz),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildFieldValue("Order #${order!.id}", ListView.builder(
                  shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                  itemCount: order!.products.length,
                  itemBuilder: (con,ind){
                    var prod=order!.products[ind];
                    return buildProduct(prod);
                  }),),

            SizedBox(height: AppSizer.getHeight(10),),
            buildNamePrice("${AppString.TEXT_SUBTOTAL}:", "\$${order!.subtotal}"),
              SizedBox(height: AppSizer.getHeight(5),),
              buildNamePrice("${AppString.TEXT_TOTAL}:", "\$${order!.total}"),

            Visibility(
              visible: (order!.status!=Order.STATUS_PENDING
                  && order!.status!=Order.STATUS_DELIVERED
                  && order!.status!=Order.STATUS_CANCEL),
              child: Padding(
                padding: EdgeInsets.only(top: AppSizer.getHeight(20)),
                child: CustomButton(
                  //text: AppString.TEXT_ORDER_RECEIVED,
                  text: AppString.TEXT_TRACK_ORDER,
                  onTap: (){
                    AppNavigator.navigateTo(TrackOrderScreen(order: order!,));
                  },
                ),
              ),
            )

          ],),):const ContentLoading();
        }
      ),
    ));
  }

  Widget buildProduct(Product product){
    const double fontsize=13;
    return Column(children: [
      buildNamePrice("${product.name}","\$${product.price} x ${product.quantity}"),
      Padding(padding: EdgeInsets.only(left: AppSizer.getWidth(10)),
        child: Column(children: [
          Visibility(
            visible: product.sidelines.isNotEmpty,
            child: buildFieldValue2(AppString.TEXT_SIDELINE,ListView.builder(
                itemCount: product.sidelines.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (con,ind){
                  var item=product.sidelines[ind];
                  return buildNamePrice("• ${item.name}", "\$${item.price} x ${item.quantity}",
                      fontsize: fontsize);
                }),color: AppColor.THEME_COLOR_PRIMARY1),
          ),
          Visibility(
            visible: product.varients.isNotEmpty,
            child: buildFieldValue2(AppString.TEXT_VARIANT,ListView.builder(
                shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                itemCount: product.varients.length,
                itemBuilder: (con,ind){
                  var item=product.varients[ind];
                  return buildNamePrice("• ${item.name}", "\$${item.price} x ${item.quantity}",
                  fontsize: fontsize);
                }),color: AppColor.THEME_COLOR_PRIMARY1),
          ),
      ],),),

    ],);
  }

  Widget buildFieldValue(String field,Widget value){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildHeading(field),
        SizedBox(height: AppSizer.getHeight(5),),
        value,
      ],);
  }

  Widget buildFieldValue2(String field,Widget value,
      {Color color=AppColor.COLOR_BLACK,}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildHeading(field,color: color,fontsize: 13),
        SizedBox(height: AppSizer.getHeight(5),),
        value,
      ],);
  }

  Widget buildNamePrice(String field,String value,{double fontsize=14,}){
    return Row(children: [
      Expanded(child: CustomText(text: field,fontweight: FontWeight.w600,
        fontsize: fontsize,)),
      CustomText(text: value,fontsize: fontsize,),
    ],);
  }

  Widget buildHeading(String text,{Color color=AppColor.COLOR_BLACK,
    double fontsize=AppDimen.FONT_CART_HEADING}){
    return CustomText(text: text,fontsize: fontsize,fontcolor: color,
      fontweight: FontWeight.w600,);
  }

/*  Widget buildSubHeading(String text,{Color color=AppColor.COLOR_BLACK}){
    return CustomText(text: text,fontsize: 14,
      fontweight: FontWeight.w600,fontcolor: color,);
  }*/
}
