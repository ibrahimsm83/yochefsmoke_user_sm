import 'package:flutter/material.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/dashboard/dashboard.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/rating_items.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {

  double rating=1;

  @override
  Widget build(BuildContext context) {
    final double diameter=AppSizer.getHeight(70);
    final double diamRad=diameter/2;
    final double radius=AppSizer.getRadius(10);
    final double paddLeft=AppSizer.getWidth(48);
    return CustomBackground(child: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSizer.getWidth(35),
        vertical: AppDimen.SCROLL_OFFSET_PADDING_VERT),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          CustomText(text:"Thank you for ordering..! enjoy your food",
              fontsize: 21,fontweight: FontWeight.w600,),

          SizedBox(height: AppSizer.getHeight(70),),

          Container(
            child: Stack(children: [
            Padding(
              padding: EdgeInsets.only(top: diamRad),
              child: Container(
                padding: EdgeInsets.fromLTRB(paddLeft, diamRad,
                    paddLeft, diamRad),
                decoration: BoxDecoration(color: AppColor.COLOR_ORANGE3,
                    borderRadius: BorderRadius.circular(radius)),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: AppSizer.getHeight(30),),
                Center(child: StarRating(size: AppSizer.getHeight(22),
                  spacing: AppSizer.getWidth(7),
                  rating: rating,
                  onRatingUpdate: (val){
                  setState(() {
                    rating=val;
                  });
                },)),
                SizedBox(height: AppSizer.getHeight(18),),
                const CustomText(text: AppString.TEXT_PLEASE_RATE,
                    fontcolor: AppColor.COLOR_GREY12,fontsize: 12,
                  textAlign: TextAlign.center,),
                  SizedBox(height: AppSizer.getHeight(40),),
                CustomButton(text: AppString.TEXT_WRITE_REVIEW,
                  bgColor: AppColor.COLOR_TRANSPARENT,border: const BorderSide(width: 1,
                      color: AppColor.THEME_COLOR_PRIMARY1),onTap: (){

                  },)
              ],),),
            ),
              Align(alignment: Alignment.topCenter,
                child: CircularButton(diameter: diameter, icon: AssetPath.ICON_TICK,
                  bgColor: AppColor.THEME_COLOR_PRIMARY1,ratio: 0.3,
                  color: AppColor.COLOR_WHITE,),
              ),
          ],),),
            SizedBox(height: AppSizer.getHeight(70),),
          CustomButton(text: AppString.TEXT_LETS_ORDER,onTap: (){
            AppNavigator.popUntil(DashboardScreen.route);
          },)


      ],),),
    ));
  }
}
