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
import 'package:ycsh/widget/textfield.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    final double radius=AppSizer.getRadius(AppDimen.BOTTOM_PANEL_RADIUS);
    final double spacing=AppSizer.getHeight(24);
    final Color bgColor=AppColor.COLOR_ORANGE2.withOpacity(0.5);
    const Color focusColor=AppColor.COLOR_BLACK;
    return CustomBackground(child: Scaffold(
    appBar: DashboardAppbar(text:AppString.TEXT_CONTACT_US,
      leading: ButtonBack(onTap: (){
        AppNavigator.pop();
      },
      ),),
      body: Column(children: [
        const CustomText(text: AppString.TEXT_FEEL_FREE,fontsize: 14,),
        SizedBox(height: AppSizer.getHeight(70),),
        Expanded(child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),topRight: Radius.circular(radius),
          ),
            color:AppColor.THEME_COLOR_PRIMARY1,
          ),
          child: Stack(
            children: [
              Positioned.fill(child: CustomImage(image: AssetPath.CONTACT_US_BG,
                fit: BoxFit.cover,)),
              Positioned.fill(
                top: AppSizer.getHeight(25),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSizer.getWidth(AppDimen.DASHBOARD_PADDING_HORZ),
                    vertical: AppDimen.SCROLL_OFFSET_PADDING_VERT,
                  ),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  buildFieldValue(AppString.TEXT_YOUR_NAME, CustomField(bgColor: bgColor,
                    focusedBorderColor: focusColor,)),
                  SizedBox(height: spacing,),
                  buildFieldValue(AppString.TEXT_YOUR_EMAIL, CustomField(bgColor: bgColor,
                  focusedBorderColor: focusColor,)),
                    SizedBox(height: spacing,),
                  buildFieldValue(AppString.TEXT_YOUR_MESSAGE,
                      DescriptionField(height: AppSizer.getHeight(150),bgColor: bgColor,
                        focusedBorderColor: focusColor,)),
                    SizedBox(height: AppSizer.getHeight(50),),
                  CustomButton(text: AppString.TEXT_SEND,bgColor: AppColor.COLOR_WHITE,),
        ],),),
              ),
            ],
          ),))
      ],),
    ));
  }

  Widget buildFieldValue(String field,Widget value){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      CustomText(text: field,fontcolor: AppColor.COLOR_WHITE,fontweight: FontWeight.w500,
      fontsize: 13,),
      SizedBox(height: AppSizer.getHeight(4),),
      value,
    ],);
  }

}
