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
import 'package:ycsh/widget/dropdown.dart';
import 'package:ycsh/widget/icons.dart';
import 'package:ycsh/widget/rating_items.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  final double iconsize=AppSizer.getHeight(18);

  int count=0;

  @override
  Widget build(BuildContext context) {
    return CustomBackground(child: Scaffold(extendBodyBehindAppBar: true,
      appBar: TransparentAppbar(leading: ButtonBack(color: AppColor.COLOR_WHITE,
        onTap: (){
          AppNavigator.pop();
        },
      ),),
      body: Container(child: Stack(children: [
        Positioned.fill(child: CustomImage(image: AssetPath.IMAGE_SAMPLE2,
          fit: BoxFit.cover,)),
        Align(
            alignment: Alignment.bottomCenter,
            child: buildBottom()),
      ],),),
    ));
  }

  Widget buildBottom(){
    final double diameter=AppSizer.getHeight(40);
    return Container(
      height: AppSizer.getPerHeight(0.52),
      padding: EdgeInsets.symmetric(
        horizontal: AppSizer.getWidth(22),vertical: AppSizer.getHeight(24)),
      decoration: BoxDecoration(color: AppColor.COLOR_WHITE),
      child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        CustomText(text: "Red Snapper Fillet",fontsize: 20,fontweight: FontWeight.w600,),
        SizedBox(height: AppSizer.getHeight(3),),
        CustomText(text: "Fried or Grilled",fontsize: 11,
        fontcolor: AppColor.COLOR_BLACK3,),
        SizedBox(height: AppSizer.getHeight(12),),
        Row(
          children: [
            StarRating(size: AppSizer.getHeight(15),),
            SizedBox(width: AppSizer.getWidth(6),),
            CustomText(text: "123 ${AppString.TEXT_REVIEWS}",
              fontcolor: AppColor.COLOR_GREY4,fontsize: 10,line_spacing: 1.4,)
          ],
        ),
        SizedBox(height: AppSizer.getHeight(18),),
        CustomText(text: "Steaks are like wine - the more you spend, the better they are, "
            "juicier, more flavor, more tender, no random bits of sinew throughout.",
          fontcolor: AppColor.COLOR_GREY4,fontsize: 13,),
          SizedBox(height: AppSizer.getHeight(15),),
        CustomDropdown(hint: "Sideline",items: ["item1","item2","item3"],
          onValueChanged: (val){

          },),
          SizedBox(height: AppSizer.getHeight(18),),
        Row(children: [
          CustomText(text: "\$40",fontsize: 23,fontweight: FontWeight.bold,),
          const Spacer(),
          Row(children: [
            buildButton(AssetPath.ICON_MINUS,onTap: (){
              setState(() {
                --count;
              });
            }),
            Container(alignment: Alignment.center,
                width: diameter,height: diameter,
                decoration: const BoxDecoration(shape: BoxShape.circle,
                      color: AppColor.THEME_COLOR_PRIMARY1),
                child: CustomText(text: "${count}",line_spacing: 1.4,
                  fontsize: 16,
                  fontweight: FontWeight.w600,)),
            buildButton(AssetPath.ICON_PLUS,onTap: (){
              setState(() {
                ++count;
              });
            }),
          ],)
        ],),
        SizedBox(height: AppSizer.getHeight(25),),
        Row(children: [
          CustomIconButton(icon: CustomMonoIcon(icon: AssetPath.ICON_HEART,
            size: AppSizer.getHeight(25),color: AppColor.COLOR_RED1,)),
          SizedBox(width: AppSizer.getWidth(10),),
          Expanded(child: CustomButton(text: AppString.TEXT_ADD_TO_CART,))
        ],)
      ],),
    ),);
  }

  Widget buildButton(String icon,{Function()? onTap,}){
    return CustomIconButton(icon: CustomMonoIcon(icon: icon,size: iconsize,
      color: AppColor.COLOR_BLACK,),onTap:onTap,);
  }

}
