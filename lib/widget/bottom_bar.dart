import 'package:flutter/material.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/icons.dart';

class DashboardNavigationBar extends StatefulWidget {

  //final void Function(int x)? onSelect;

  final int selected;
  final List<DashboardNavigationBarItem> items;
  final double height;
  final void Function(int index) onChanged;
  const DashboardNavigationBar({Key? key,//required this.onSelect,
    required this.onChanged,
    this.selected=0,required this.height, this.items=const [],}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _DashboardNavigationBarState();
  }

}

class _DashboardNavigationBarState extends State<DashboardNavigationBar> {



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topBorderRadius=AppSizer.getRadius(12);
    final bottomBorderRadius=AppSizer.getRadius(33);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizer.getWidth(13),
          vertical: AppSizer.getHeight(15)),
      child: Container(height: widget.height,//color: AppColor.COLOR_BLACK,
         // padding: EdgeInsets.symmetric(horizontal: AppDimen.DASHBOARD_PADDING_HORZ.w),
        clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColor.THEME_COLOR_PRIMARY1,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(topBorderRadius),
            topRight: Radius.circular(topBorderRadius),
                bottomLeft: Radius.circular(bottomBorderRadius),
            bottomRight: Radius.circular(bottomBorderRadius),)
          ),
          child: Row(
            children: List.generate(widget.items.length, (index) {
              return buildItem(widget.items[index],index);
            }),
          ),),
    );
  }


  Widget buildItem(DashboardNavigationBarItem child,int index){
    return Expanded(child: child);
  }



}

class DashboardNavigationBarItem extends StatelessWidget{

  // final String title;
  final String icon;
  final String title;
  final bool selected;
  final void Function()? onTap;

  DashboardNavigationBarItem({this.title="",
    required this.icon,required this.selected,
    this.onTap,});


  @override
  Widget build(BuildContext context) {
    final double iconsize=AppSizer.getHeight(23);
    return Material(color: AppColor.COLOR_TRANSPARENT,
      child: InkWell(onTap: onTap,
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomMonoIcon(icon: icon,size: iconsize,color: AppColor.COLOR_WHITE,),
              const SizedBox(height: 5,),
              CustomText(text: title,max_lines: 1,
                fontcolor: selected?AppColor.COLOR_WHITE:AppColor.COLOR_TRANSPARENT,
                fontweight: FontWeight.bold,fontsize: 9,),

            ],),
        ),
      ),
    );
  }

}