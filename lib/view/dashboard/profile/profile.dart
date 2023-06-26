import 'package:flutter/material.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/icons.dart';
import 'package:ycsh/widget/profile_items.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final double radius=AppSizer.getRadius(12);
    return Scaffold(extendBodyBehindAppBar: true,
      appBar: DashboardAppbar(text: AppString.TEXT_PROFILE,),
      body: LayoutBuilder(
        builder: (con,cons) {
          var size=cons.biggest;
          final double height=AppSizer.getHeight(265);
          return Stack(children: [
            Positioned.fill(
              child: Container(//color: Colors.green,
                child: SingleChildScrollView(
                  child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(height:height,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(child: const CustomImage(
                              image:AssetPath.PROFILE_BG,
                              fit: BoxFit.cover,),),
                          ),
                          Positioned.fill(
                            top:AppSizer.getHeight(AppDimen.DASHBOARD_APPBAR_HEIGHT),
                            child: Column(children: [
                              SizedBox(height: AppSizer.getHeight(10),),
                              EditProfilePicture(onEdit: (){

                              },),
                              SizedBox(height: AppSizer.getHeight(12),),
                              CustomText(text: "Jane Doe",fontcolor: AppColor.COLOR_BLACK,
                                fontweight: FontWeight.bold,fontsize: 16,)
                            ],),
                          ),
                        ],
                      ),
                    ),
                    buildBottom(size.height-height),
                  ],),),
              ),
            ),
            Align(
              alignment: const FractionalOffset(0.5,0.39),
              child: ShadowContainer(radius: radius,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: AppSizer.getHeight(5)),
                  color: AppColor.COLOR_WHITE,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildStatContainer(AppString.TEXT_RATING, 4.5),
                      buildStatContainer(AppString.TEXT_ORDER, 40),
                      buildStatContainer(AppString.TEXT_FOLLOWERS, 80,border: false),
                    ],),
                ),),
            ),
          ],);
        }
      ),
    );
  }

  Widget buildBottom(double height){
    final double radius=AppSizer.getRadius(AppDimen.BOTTOM_PANEL_RADIUS);
    final double horzPadd= AppSizer.getWidth(AppDimen.DASHBOARD_PADDING_HORZ),
        vertPadd=AppSizer.getHeight(AppDimen.DASHBOARD_NAVIGATION_BAR_HEIGHT);
    final double spacing=AppSizer.getHeight(20);
    return Container(
      constraints: BoxConstraints(minHeight: height),
      padding: EdgeInsets.fromLTRB(horzPadd,AppSizer.getHeight(40),
          horzPadd,vertPadd),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColor.COLOR_GREY5,
        //color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),topRight: Radius.circular(radius)),),
      child: Column(children: [
        buildFieldValue(AppString.TEXT_NAME,EditField(hinttext: AppString.TEXT_NAME,),),
        SizedBox(height: spacing,),
        buildFieldValue(AppString.TEXT_PHONE_NUMBER,
          EditField(hinttext: AppString.TEXT_PHONE_NUMBER,),),
        SizedBox(height: spacing,),
        buildFieldValue(AppString.TEXT_ADDRESS, Container(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const CustomText(text: AppString.TEXT_HOME,fontsize: 15,
            fontweight: FontWeight.bold,),
          Row(
            children: [
              Expanded(child: CustomText(text: "9922 Cardinal Street Minot, \nND 58701",
                fontsize: 12,line_spacing: 1.6,),),
              GestureDetector(
                child: Container(color: AppColor.COLOR_TRANSPARENT,
                  padding: EdgeInsets.symmetric(horizontal: AppSizer.getWidth(
                      AppDimen.LOGINFIELD_ICON_HORZ_PADDING)),
                  child: IconEdit(size: AppSizer.getHeight(12),),
                ),
              ),
            ],
          ),
        ],),),),
    ],),);
  }

  Widget buildStatContainer(String field,num value,{bool border=true,}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSizer.getWidth(20),
          vertical: AppSizer.getHeight(5)),
      decoration: BoxDecoration(
          border: border?const Border(right: BorderSide(width: 1,
              color: AppColor.COLOR_GREY2)):
              const Border()
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
      CustomText(text: field,fontweight: FontWeight.bold,fontsize: 14,),
      SizedBox(height: AppSizer.getHeight(2),),
      CustomText(text: "$value",fontsize: 9,fontcolor: AppColor.COLOR_BLACK3,
        fontweight: FontWeight.w500,),
    ],),);
  }

  Widget buildFieldValue(String field,Widget value){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      CustomText(text:field,fontcolor: AppColor.COLOR_BLACK3,fontsize: 12,
        fontweight: FontWeight.w500,
      ),
      SizedBox(height: AppSizer.getHeight(10),),
      value,
    ],);
  }

}
