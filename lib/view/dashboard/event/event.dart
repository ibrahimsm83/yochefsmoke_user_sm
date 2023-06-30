import 'package:flutter/material.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/dashboard/event/event_detail.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/event_items.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomBackground(child: Scaffold(
      appBar: DashboardAppbar(text:AppString.TEXT_EVENTS,
        leading: ButtonBack(onTap: (){
          AppNavigator.pop();
        },
      ),),
      body: ListView.separated(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizer.getWidth(AppDimen.DASHBOARD_PADDING_HORZ),
            vertical: AppDimen.SCROLL_OFFSET_PADDING_VERT,
          ),
          itemBuilder: (con,ind){
        return EventContainer(color: ind.isEven?AppColor.COLOR_BLACK:
        AppColor.THEME_COLOR_PRIMARY1,onTap: (){
          AppNavigator.navigateTo(EventDetailScreen());
        },);
      }, separatorBuilder:(con,ind){
        return SizedBox(height: AppSizer.getHeight(17),);
      }, itemCount: 7),
    ));
  }
}
