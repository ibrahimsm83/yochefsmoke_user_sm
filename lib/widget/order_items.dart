import 'package:flutter/material.dart';
import 'package:ycsh/model/order.dart';
import 'package:ycsh/service/image_chooser.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/datetime.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/widget/common.dart';

import 'profile_items.dart';

class OrderContainer extends StatelessWidget {

  final void Function()? onTap;
  final Order order;
  const OrderContainer({Key? key,this.onTap,required this.order,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius=AppSizer.getRadius(20);
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
                  CustomText(
                    text: "${order.address?.location!.name}",
                    fontcolor: AppColor.COLOR_GREY4,fontsize: 13,
                  ),
                  SizedBox(height: AppSizer.getHeight(7),),
                  Row(crossAxisAlignment: CrossAxisAlignment.center,
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
                          text: order.status,
                          fontcolor: Order.colorMap[order.status]??AppColor.THEME_COLOR_PRIMARY1,
                          line_spacing: 1,max_lines: 1,fontsize: 13,
                          fontweight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: AppSizer.getHeight(15),),
                  Row(
                    children: [
                      CircularPic(diameter: AppSizer.getHeight(40),
                        imageType: ImageType.TYPE_NETWORK,image: order.rider?.image,),
                      SizedBox(width: AppSizer.getWidth(10),),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text:'${order.rider?.fullname}',fontsize: 14,
                              fontweight: FontWeight.w600,),
                          ],
                        ),
                      ),
                      /* Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
               *//*           ElevatedButton(
                          onPressed: () {
                            Constant.makePhoneCall(data.phone.toString());
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.blue,
                            shape: const CircleBorder(),
                            backgroundColor: Colors.blue,
                            padding:
                            const EdgeInsets.all(6), // <-- Splash color
                          ),
                          child: const Icon(
                            Icons.call,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        Text(data.dateRetour.toString(),
                            style: const TextStyle(
                                color: Colors.black26,
                                fontWeight: FontWeight.w600)),*//*
                      ],
                    )*/
                    ],
                  ),
                  SizedBox(height: AppSizer.getHeight(10),),
                  Row(
                    children: [
                      Expanded(child: CustomText(
                        fontsize: 13,text: "Order #${order.id}",
                        fontweight: FontWeight.w600,
                      )),
                      CustomText(
                        //text: "21 Sept, 2022",
                        text:DateTimeManager.getFormattedDateTime(order.date!,
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
