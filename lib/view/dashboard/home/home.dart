import 'package:flutter/material.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/profile_items.dart';

class HomeScreen extends StatefulWidget {
  final void Function()? onOpenDrawer;
  const HomeScreen({Key? key,this.onOpenDrawer,}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: LogoAppbar(leading: ButtonDrawer(onTap: widget.onOpenDrawer,),
      action: CircularPic(diameter: AppSizer.getHeight(AppDimen.APPBAR_PROF_PIC_SIZE,)),),);
  }
}
