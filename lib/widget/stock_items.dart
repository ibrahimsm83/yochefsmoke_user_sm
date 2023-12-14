import 'package:flutter/material.dart';
import 'package:ycsh/model/stock.dart';
import 'package:ycsh/service/image_chooser.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/datetime.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/widget/common.dart';

class StockContainer extends StatelessWidget {

  final void Function()? onTap;
  final Stock stock;
  const StockContainer({Key? key,this.onTap,required this.stock,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius=AppSizer.getRadius(20);
    final double img_height=AppSizer.getHeight(55);

    const double fontsize=13;
    return ShadowContainer(radius: radius,
      child: Container(
        decoration: BoxDecoration(color: AppColor.COLOR_GREY1,
            borderRadius: BorderRadius.circular(radius)),
        child: Material(color: AppColor.COLOR_TRANSPARENT,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizer.getWidth(12),
                vertical: AppSizer.getHeight(14),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
/*                  CustomText(
                    text: "${order.address?.location!.name}",
                    fontcolor: AppColor.COLOR_GREY4,fontsize: 13,
                  ),
                  SizedBox(height: AppSizer.getHeight(7),),*/
/*                  Row(crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DottedContainer(dashlength: 4,dashspacing: 12,),
                          ],
                        ),
                      ),
                      SizedBox(width: AppSizer.getWidth(10),),
                      Container(//color: Colors.red,
                        child: CustomText(
                          text: Order.statusMap[order.status]!,
                          fontcolor: Order.colorMap[order.status]??AppColor.THEME_COLOR_PRIMARY1,
                          line_spacing: 1,max_lines: 1,fontsize: 13,
                          fontweight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: AppSizer.getHeight(15),),*/
                  Row(crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(width: img_height*1.1,height: img_height,
                        child: CustomImage(
                          fit: BoxFit.cover,
                        image: stock.product!.image,imageType: ImageType.TYPE_NETWORK,
                      ),),
                      SizedBox(width: AppSizer.getWidth(10),),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text:'${stock.product?.name}',fontsize: 14,
                              fontweight: FontWeight.w600,),
                            CustomText(text:'${stock.product?.cook_type}',fontsize: 12,),
                            Visibility(visible: stock.product!.frozen,
                              child: Padding(
                                padding: EdgeInsets.only(top: AppSizer.getHeight(2)),
                                child: const CustomText(text:'frozen',
                                    fontsize: 11,fontweight: FontWeight.w600,
                                    fontcolor:AppColor.COLOR_BLUE1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizer.getHeight(10),),
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          fontsize: fontsize,text: "Quantity: ",
                          fontweight: FontWeight.w600,
                        ),
                      ),
                      CustomText(
                        fontsize: fontsize,
                        text: "\$${stock.product!.price} x ${stock.quantity}",
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizer.getHeight(10),),
                  Row(
                    children: [
                      Expanded(child: CustomText(
                        fontsize: fontsize,text: "Stock #${stock.id}",
                        fontweight: FontWeight.w600,
                      )),
         /*             Expanded(child: CustomText(
                        fontsize: fontsize,text: "Order #${stock.order_id}",
                        fontweight: FontWeight.w600,
                      )),*/
                      CustomText(
                        //text: "21 Sept, 2022",
                        text:DateTimeManager.getFormattedDateTime(stock.date!,
                            format: DateTimeManager.dateFormat2,
                            format2: DateTimeManager.dateTimeFormat),
                        fontsize: 13,
                        fontweight: FontWeight.w500,fontcolor: AppColor.COLOR_BLUE1,),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),),
    );
  }
}