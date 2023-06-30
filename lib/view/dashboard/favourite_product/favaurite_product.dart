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

class FavouriteProductScreen extends StatefulWidget {
  final bool back_enabled;
  const FavouriteProductScreen({Key? key, this.back_enabled = true})
      : super(key: key);

  @override
  State<FavouriteProductScreen> createState() => _FavouriteProductScreenState();
}

class _FavouriteProductScreenState extends State<FavouriteProductScreen> {

  int selected=0;

  @override
  Widget build(BuildContext context) {
    final double paddHorz=AppSizer.getWidth(AppDimen.DASHBOARD_PADDING_HORZ);
    final double gridSpacing=AppSizer.getHeight(15);
    return CustomBackground(safe: false,
        child: Scaffold(
            appBar: DashboardAppbar(
              text: AppString.TEXT_FAVOURITES,
              leading: widget.back_enabled
                  ? ButtonBack(
                      onTap: () {
                        AppNavigator.pop();
                      },
                    )
                  : null,
            ),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddHorz),
                  child: SearchField(
                    hinttext: AppString.TEXT_SEARCH_FOOD,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                        vertical: AppDimen.SCROLL_OFFSET_PADDING_VERT),
                    child: Column(children: [
                    Container(height: AppSizer.getHeight(100),
                      child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: paddHorz),
                      itemCount: 7,
                      separatorBuilder: (con,ind){
                        return SizedBox(width: AppSizer.getWidth(30),);
                      },
                      itemBuilder:(con,ind){
                        return MenuContainer2(
                          selected: selected==ind,
                          onTap: (){
                            setState(() {
                              selected=ind;
                            });
                          },);
                      },
                      scrollDirection: Axis.horizontal,
                    ),),
                      GridView.builder(
                        padding: EdgeInsets.fromLTRB(paddHorz,AppSizer.getHeight(15),
                          paddHorz,AppSizer.getHeight(AppDimen.DASHBOARD_NAVIGATION_BAR_HEIGHT)),
                        shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                            mainAxisSpacing: gridSpacing,crossAxisSpacing: gridSpacing,
                            childAspectRatio: 0.7),
                        itemCount: 6,itemBuilder: (con,ind){
                        return FoodContainer(onTap: (){
                          AppNavigator.navigateTo(ProductDetailScreen());
                        },);
                      },
                      )
                  ],),),
                )
              ],
            )));
  }
}
