import 'package:flutter/material.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({Key? key}) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomBackground(child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TransparentAppbar(leading: ButtonBack(color: AppColor.COLOR_WHITE,
        onTap: (){
          AppNavigator.pop();
        },
      ),),
      body: SingleChildScrollView(child: Column(
        children: [
          Container(height: AppSizer.getHeight(280),child: Stack(children: [
            Positioned.fill(child: Container(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomImage(image: AssetPath.IMAGE_SAMPLE2,
                      fit: BoxFit.cover,),
                  ),
                  Positioned.fill(
                    child: Container(decoration: BoxDecoration(gradient: LinearGradient(
                        begin: Alignment.topCenter,end: Alignment.bottomCenter,
                        stops: [0,0.6,1],
                        colors: [
                          AppColor.COLOR_BLACK,AppColor.COLOR_TRANSPARENT,
                          AppColor.COLOR_TRANSPARENT,
                        ])),),
                  ),
                ],
              ),
            ),bottom: AppSizer.getHeight(10),),
            Align(
                alignment: Alignment.bottomRight,
                child: buildRoundContainer("17 April")),
          ],),),
          Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppDimen.SCROLL_OFFSET_PADDING_VERT,
                  horizontal: AppSizer.getWidth(AppDimen.DASHBOARD_PADDING_HORZ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
            CustomText(text: "Your event name goes here",fontweight: FontWeight.bold,
            fontsize: 17,),
                SizedBox(height: AppSizer.getHeight(32),),
                Container(
                  padding: EdgeInsets.only(bottom: AppSizer.getHeight(18)),
                  decoration: const BoxDecoration(border:
                  const Border(bottom: BorderSide(width: 1, color: AppColor.COLOR_GREY11))),
                  child: Row(children: [
                  Expanded(child: buildTime(AppString.TEXT_TIME,"5:30pm - 7:30pm")),
                  Expanded(child: buildTime(AppString.TEXT_DATE,"17 April 2023")),
                ],),),
                  SizedBox(height: AppSizer.getHeight(30),),
                  CustomText(text: "But I must explain to you how all this mistaken idea of "
                      "denouncing pleasure and a praising pain was born and I will give you "
                      "a complete pain was born and I will give you a complete pain was born "
                      "and I will give you a complete",fontsize: 13,
                    fontcolor: AppColor.COLOR_BLACK3,line_spacing: 1.4,),
                  SizedBox(height: AppSizer.getHeight(27),),
                  CustomText(text: AppString.TEXT_ADDRESS,fontsize: 12,
                    fontweight: FontWeight.w600,),
                  SizedBox(height: AppSizer.getHeight(5),),
                  buildAddress(AppString.TEXT_STREET,"2199 Finwood Road"),
                  SizedBox(height: AppSizer.getHeight(3),),
                  buildAddress(AppString.TEXT_CITY,"New Brunswick"),
                  SizedBox(height: AppSizer.getHeight(30),),
                  CustomButton(text: AppString.TEXT_GET_TICKET,),
          ],))
        ],
      ),),
    ));
  }

  Widget buildAddress(String title,String text){
    const double fontsize=13;
    return Row(children: [
      CustomText(text: "${title}: ",fontsize: fontsize,fontweight: FontWeight.w600,),
      CustomText(text: text,fontsize: fontsize,),
    ],);
  }

  Widget buildTime(String text,String value){
    const double fontsize=12;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      CustomText(text: text,fontcolor: AppColor.COLOR_GREY11,fontsize: fontsize,),
      SizedBox(height: AppSizer.getHeight(5),),
      CustomText(text: value,fontcolor: AppColor.COLOR_BLACK,fontsize: fontsize,
      fontweight: FontWeight.w600,)
    ],);
  }

  Widget buildRoundContainer(String text){
    final double radius=AppSizer.getRadius(30);
    final double paddVert=AppSizer.getHeight(11);
    return Container(
      padding: EdgeInsets.fromLTRB(AppSizer.getWidth(25), paddVert,
          AppSizer.getWidth(18), paddVert),
      decoration: BoxDecoration(color: AppColor.THEME_COLOR_PRIMARY1,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(radius),
              bottomLeft: Radius.circular(radius))),
      child: CustomText(text: text,fontsize: 14,fontweight: FontWeight.bold,),);
  }
}
