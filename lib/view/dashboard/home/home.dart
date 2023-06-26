import 'package:flutter/material.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/dashboard/Profile/profile.dart';
import 'package:ycsh/view/dashboard/home/menu_category.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/home_items.dart';
import 'package:ycsh/widget/profile_items.dart';

import 'product_detail.dart';

class HomeScreen extends StatefulWidget {
  final void Function()? onOpenDrawer;
  const HomeScreen({Key? key,this.onOpenDrawer,}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double paddHorz=AppSizer.getHeight(AppDimen.DASHBOARD_PADDING_HORZ);
    final double spacing=AppSizer.getHeight(20);
    final double gridSpacing=AppSizer.getHeight(15);
    return Scaffold(appBar: LogoAppbar(leading: ButtonDrawer(onTap: widget.onOpenDrawer,),
      action: GestureDetector(
          onTap: (){
            AppNavigator.navigateTo(ProfileScreen());
          },
          child: CircularPic(diameter: AppSizer.getHeight(AppDimen.APPBAR_PROF_PIC_SIZE,))),),
    body: Column(children: [
      Padding(padding: EdgeInsets.symmetric(horizontal: paddHorz),
        child: SearchField(hinttext: AppString.TEXT_SEARCH_FOOD,),),
      Expanded(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: paddHorz,
              vertical: AppDimen.SCROLL_OFFSET_PADDING_VERT),
          child: Column(children: [
            Container(height: AppSizer.getHeight(115),
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (con,ind){
                return SpecialContainer();
              }, separatorBuilder: (con,ind){
                return SizedBox(width: AppSizer.getWidth(18),);
              }, itemCount: 5),),
            SizedBox(height: spacing,),
            buildFieldValue(AppString.TEXT_MENU,Container(height: AppSizer.getHeight(100),
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (con,ind){
                    return MenuCategoryContainer(onTap: (){
                      AppNavigator.navigateTo(MenuCategoryScreen());
                    },);
                  }, separatorBuilder: (con,ind){
                return SizedBox(width: AppSizer.getWidth(10),);
              }, itemCount: 5),),),
            SizedBox(height: spacing,),
            buildFieldValue(AppString.TEXT_FOD_OF_DAY,GridView.builder(

              shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                  mainAxisSpacing: gridSpacing,crossAxisSpacing: gridSpacing,
                  childAspectRatio: 0.7),
              itemCount: 6,itemBuilder: (con,ind){
              return FoodContainer(onTap: (){
                AppNavigator.navigateTo(ProductDetailScreen());
              },);
            },
            ),),



        ],),),
      )
    ],),
    );
  }

  Widget buildFieldValue(String field,Widget value){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
      buildHeading(field),
      SizedBox(height: AppSizer.getHeight(4),),
      value,
    ],);
  }

  Widget buildHeading(String text){
    return CustomText(text: text,fontcolor: AppColor.COLOR_BLACK,
      fontweight: FontWeight.w600,fontsize: 20,);
  }

}
