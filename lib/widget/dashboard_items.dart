import 'package:flutter/material.dart';
import 'package:ycsh/model/user.dart';
import 'package:ycsh/service/image_chooser.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/icons.dart';
import 'package:ycsh/widget/profile_items.dart';

import '../utils/strings.dart';

class CustomDrawer extends StatelessWidget{

  final List<DrawerItem> items;
  final void Function() onClose;
  final void Function()? onLogoutTap;
  //final StakeHolder user;
  CustomDrawer({required this.items,required this.onClose,this.onLogoutTap,});


  late double _sidePadd;

  @override
  Widget build(BuildContext context) {
    final double width= AppSizer.getPerWidth(0.9);
    return Container(width: width,
    //  clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildTopContainer(width),
          Expanded(child: Padding(
            padding: EdgeInsets.only(left:_sidePadd,),
            child: Container(color: AppColor.COLOR_WHITE,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  for(int i=0;i<items.length;i++)
                    items[i],
                  Padding(
                    padding: EdgeInsets.only(
                      left: AppSizer.getWidth(AppDimen.DRAWER_ITEM_PADDING_HORZ)),
                    child: LogoutButton(onTap: onLogoutTap,),
                  ),
                ],),
              ),
            ),
          )),
          //   BottomLabelText(),
        ],
      ),
    );
  }

  Widget buildTopContainer(double width){
    final double height=AppSizer.getHeight(170);
   // final double radius=height*0.65;
    final double radius=AppSizer.getRadius(60);
    _sidePadd=radius*0.3;
    return Container(color: AppColor.COLOR_TRANSPARENT,
     // padding: EdgeInsets.only(top: topPadd,right: topPadd,bottom: 35.h),
      width: width,
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
              left: radius*0.3,
              child: Container(color: AppColor.THEME_COLOR_PRIMARY1,)),
          Center(child: Container(height: height*0.65,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Center(
                child: Padding(
                  padding:  EdgeInsets.only(left: radius*0.18),
                  child: CircularPic(diameter: height*0.45,),
                ),
              ),
              SizedBox(width: AppSizer.getWidth(18),),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  CustomText(text:"Jane Doe",fontweight: FontWeight.bold,fontsize: 17,),
                  SizedBox(height: AppSizer.getHeight(3),),
                  CustomText(text:"info@chinchu.com",fontcolor: AppColor.COLOR_WHITE,
                    fontsize: 11,fontweight: FontWeight.bold,),
                ],),
              ),
              Padding(
                padding: EdgeInsets.only(top: AppSizer.getHeight(10)),
                child: ButtonBack(onTap: onClose,),
              ),
            ],),
            decoration: BoxDecoration(color: AppColor.THEME_COLOR_PRIMARY1,
                borderRadius: BorderRadius.circular(radius)),
            width: width,)),


        ],),);
  }


}

class DrawerItem extends StatefulWidget{

  final String title;
  final String? icon;
  final Color color;
  final void Function()? onTap;
  const DrawerItem({Key? key, this.title="",this.icon,this.onTap,
    this.color=AppColor.COLOR_BLACK2}):
        super(key:key,);


  @override
  State createState() {
    return _DrawerItemState();
  }

}


class _DrawerItemState extends State<DrawerItem>{

  Widget build(BuildContext context){
    final double iconsize=AppSizer.getHeight(15);
    return Material(
        color: AppColor.COLOR_TRANSPARENT,
        child:InkWell(
          onTap: widget.onTap, child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizer.getWidth(AppDimen.DRAWER_ITEM_PADDING_HORZ),
              vertical:AppSizer.getHeight(15)),
          child: Container(
            child: Row(children: [
              CustomMonoIcon(icon: widget.icon!,size: iconsize,color: widget.color,),
              SizedBox(width: AppSizer.getWidth(25),),
              Expanded(child: Container(
                  child: CustomText(text: widget.title,fontsize: 13,line_spacing: 1.3,
                    fontcolor: widget.color,fontweight: FontWeight.w600,))),

            ],),
          ),
        ),
        ));
  }

}

class LogoutButton extends CustomButton{
  LogoutButton({void Function()? onTap,}):
        super(bgColor: AppColor.COLOR_RED1,text: AppString.TEXT_SIGNOUT,onTap: onTap,
          textColor: AppColor.COLOR_WHITE,fontsize: 10,fontWeight: FontWeight.w500);

  @override
  // TODO: implement child
  Widget get child {
    final double iconsize=AppSizer.getFontSize(fontsize+4);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
      IconLogout(color: textColor,size: iconsize,),
      SizedBox(width: AppSizer.getWidth(10),),
      super.child,
    ],);
  }

  @override
  EdgeInsets? get padding => EdgeInsets.symmetric(horizontal: AppSizer.getWidth(18),
  vertical: AppSizer.getHeight(7));

}


/*
class TriggerableDrawerItem extends DrawerItem {

  //final AdvancedSwitchController controller=AdvancedSwitchController();

  //GlobalKey<_TriggerableDrawerItemState> key=GlobalKey();

  final void Function(bool val) onChange;
  final bool value;
  const TriggerableDrawerItem({Key? key,String title="",String? icon,required this.onChange,//this.controller,
    this.value=false,}):super(title: title,icon: icon,key: key,);


  @override
  _TriggerableDrawerItemState createState() {
    return _TriggerableDrawerItemState();
  }


// AdvancedSwitchController get controller=> (key as GlobalKey<_TriggerableDrawerItemState>).currentState!.controller;



}

class _TriggerableDrawerItemState extends _DrawerItemState{


  late ValueNotifier<bool> controller;

  @override
  TriggerableDrawerItem get widget => (super.widget as TriggerableDrawerItem);

  @override
  void initState() {
    controller=ValueNotifier(widget.value);
    controller.addListener(() {
      widget.onChange(controller.value);
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DrawerItem oldWidget) {
    controller.value=widget.value;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  */
/* @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }*//*



  @override
  Widget buildIcon(double size) {
    return CustomSwitch(controller:controller,width: 28.w,height: 15.h,
      thumbColor: AppColor.COLOR_WHITE,);
  }

}*/