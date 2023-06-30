import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ycsh/controller/dashboard_controller.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/dashboard/Profile/profile.dart';
import 'package:ycsh/view/dashboard/cart/cart.dart';
import 'package:ycsh/view/dashboard/contact_us.dart';
import 'package:ycsh/view/dashboard/event/event.dart';
import 'package:ycsh/view/dashboard/favourite_product/favaurite_product.dart';
import 'package:ycsh/view/dashboard/home/home.dart';
import 'package:ycsh/view/splash/onboarding/onboarding.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/bottom_bar.dart';
import 'package:ycsh/widget/dashboard_items.dart';

import 'track_order/track_order.dart';

class DashboardScreen extends StatefulWidget {

  static const route="/DashboardScreen";

  final int selected;
  const DashboardScreen({Key? key,this.selected=0,}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<Widget> screens;

  bool _forward=false;
  late int _prev_sel;
  late PageController _pageController;

  late int selected;

  final GlobalKey<ScaffoldState> _drawerKey=GlobalKey();

  @override
  void initState() {
    onInit();
    selected=widget.selected;
    _prev_sel=selected;
    _pageController=PageController(initialPage: _prev_sel,);
    _pageController.addListener(() {
     // setState(() {});
    });
    super.initState();
  }

  void goTo(Widget widget){
    AppNavigator.pop();
    AppNavigator.navigateTo(widget);
  }

  void onInit(){
    screens=[HomeScreen(onOpenDrawer: openDrawer,),
      CartScreen(back_enabled:false,),FavouriteProductScreen(back_enabled: false,),
      ProfileScreen(back_enabled:false,)];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height=AppSizer.getHeight(AppDimen.DASHBOARD_NAVIGATION_BAR_HEIGHT);
    return CustomBackground(child: Scaffold(
      key: _drawerKey,
      endDrawer: buildDrawer(),
  /*    drawer: GetBuilder<DashboardController>(
          builder: (context) {
            return buildDrawer();
          }
      ),*/
      extendBody: true,
      body: PageView.builder(//key: GlobalKey(),
          controller: _pageController,
          itemCount: screens.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (con,ind){
            // print("builder is called $ind");
            return _forward?(ind==0?screens[_prev_sel]:screens[selected]):
            (ind==0?screens[selected]:screens[_prev_sel]);
          }),
      bottomNavigationBar: buildNavigationBar(height,),
    ));
  }

  void openDrawer(){
    _drawerKey.currentState?.openEndDrawer();
  }

  CustomDrawer buildDrawer(){
    return CustomDrawer(
    //  user: controller.user,
      onLogoutTap: (){
        AppNavigator.navigateToReplaceAll(() => OnboardingScreen());
      },
      onClose: (){
        AppNavigator.pop();
      },
      items: [
        DrawerItem(title: AppString.TEXT_HOME,icon: AssetPath.ICON_HOME2,),
        DrawerItem(title: AppString.TEXT_CART,icon: AssetPath.ICON_DINER,onTap: (){
          goTo(CartScreen());
        },),
        DrawerItem(title: AppString.TEXT_FAVOURITES,icon: AssetPath.ICON_HEART,onTap: (){
          goTo(FavouriteProductScreen());
        }),
        DrawerItem(title: AppString.TEXT_PROFILE,icon: AssetPath.ICON_USER,onTap: (){
          goTo(ProfileScreen());
        }),
        DrawerItem(title: AppString.TEXT_TRACK_ORDER,icon: AssetPath.ICON_LOCATION,onTap: (){
          goTo(TrackOrderScreen());
        },),
        DrawerItem(title: AppString.TEXT_EVENTS,icon: AssetPath.ICON_CALENDAR,onTap: (){
          goTo(EventScreen());
        }),
        DrawerItem(title: AppString.TEXT_CONTACT_US,icon: AssetPath.ICON_PHONE,onTap: (){
          goTo(ContactUsScreen());
        }),
        DrawerItem(title: AppString.TEXT_TERMS_CONDITIONS,icon: AssetPath.ICON_MEMO,onTap: (){},),
        DrawerItem(title: AppString.TEXT_FAQ,icon: AssetPath.ICON_FAQ,onTap: (){}),
        DrawerItem(title: AppString.TEXT_ABOUT_US,icon: AssetPath.ICON_INFO,onTap: (){}),
      ],);
  }


  DashboardNavigationBar buildNavigationBar(double height){
    return DashboardNavigationBar(
      onChanged: (index){

      },
      height: height,
      selected: selected,
      items: [
        DashboardNavigationBarItem(
          title: AppString.TEXT_HOME,
          icon: selected==0?AssetPath.ICON_HOME_FILLED:AssetPath.ICON_HOME,
          selected: selected==0,onTap: (){
          select(0);
        },),
        DashboardNavigationBarItem(
          title: AppString.TEXT_CART,
          icon: selected==1?AssetPath.ICON_DINER_FILLED:AssetPath.ICON_DINER,
          selected: selected==1,
          onTap: (){
            select(1);
          },),
        DashboardNavigationBarItem(
          title: AppString.TEXT_FAVOURITES,
          icon:selected==2?AssetPath.ICON_HEART_FILLED:AssetPath.ICON_HEART,
          selected: selected==2,
          onTap: (){
            select(2);
          },),
        DashboardNavigationBarItem(
          title: AppString.TEXT_PROFILE,
          icon:selected==3?AssetPath.ICON_USER_FILLED:AssetPath.ICON_USER,
          selected: selected==3,
          onTap: (){
            select(3);
          },),
      ],
    );
  }

  void select(int x){
    _prev_sel = selected;
    selected = x;
    if(selected!=_prev_sel) {
      setState(() {
        _forward=selected>_prev_sel;
        _pageController.jumpToPage(_forward?0:1);
        //page=controller.page!;
        _pageController.animateToPage(_forward ? 1 : 0,
            duration: const Duration(
                milliseconds: AppInteger.SWIPE_DURATION_MILLI),
            curve: Curves.linear);
      });
    }
  }
}
