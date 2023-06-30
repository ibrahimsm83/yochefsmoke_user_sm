import 'package:flutter/material.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/dashboard/home/product_detail.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/home_items.dart';
import 'package:ycsh/widget/menu_items.dart';

class MenuCategoryScreen extends StatefulWidget {
  const MenuCategoryScreen({Key? key}) : super(key: key);

  @override
  State<MenuCategoryScreen> createState() => _MenuCategoryScreenState();
}

class _MenuCategoryScreenState extends State<MenuCategoryScreen> {

  int selected=0;

  @override
  Widget build(BuildContext context) {
    final double paddHorz=AppSizer.getWidth(AppDimen.DASHBOARD_PADDING_HORZ);
    final double gridSpacing=AppSizer.getHeight(15);
    return CustomBackground(child: Scaffold(
    appBar: LogoAppbar(leading: ButtonBack(onTap: (){
      AppNavigator.pop();
    },),),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddHorz),
          child: SearchField(hinttext: AppString.TEXT_SEARCH_FOOD,),
        ),
        Container(height: AppSizer.getHeight(50),child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: paddHorz),
          itemCount: 7,
          separatorBuilder: (con,ind){
            return SizedBox(width: AppSizer.getWidth(30),);
          },
          itemBuilder:(con,ind){
            return Center(child: MenuCategoryContainer(text:"Brunch",
              selected: selected==ind,
              onTap: (){
                setState(() {
                  selected=ind;
                });
              },));
          },
          scrollDirection: Axis.horizontal,
        ),),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: paddHorz),
            //shrinkWrap: true,
           // physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                mainAxisSpacing: gridSpacing,crossAxisSpacing: gridSpacing,
                childAspectRatio: 0.7),
            itemCount: 6,itemBuilder: (con,ind){
            return FoodContainer(onTap: (){
              AppNavigator.navigateTo(ProductDetailScreen());
            },);
          },
          ),
        )
      ],),
    ));
  }
}
