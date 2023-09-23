import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ycsh/controller/user/order_controller.dart';
import 'package:ycsh/model/order.dart';
import 'package:ycsh/model/page_model.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/dashboard/track_order/track_order.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/loader.dart';
import 'package:ycsh/widget/order_items.dart';
import 'package:ycsh/widget/pagenation/paged_listview.dart';
import 'package:ycsh/widget/pagenation/paged_view.dart';

class ActiveOrdersScreen extends StatefulWidget {
  const ActiveOrdersScreen({Key? key}) : super(key: key);

  @override
  State<ActiveOrdersScreen> createState() => _ActiveOrdersScreenState();
}

class _ActiveOrdersScreenState extends State<ActiveOrdersScreen> {

  final OrderController orderController=Get.find<OrderController>();

  final GlobalKey<PagedViewState> pageKey=GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double spacing= AppSizer.getHeight(15);
    return CustomBackground(child: Scaffold(
      appBar: DashboardAppbar(text:AppString.TEXT_ACTIVE_ORDERS,
        leading: ButtonBack(onTap: (){
          AppNavigator.pop();
        },),),
      body: RefreshIndicator(
        onRefresh: () async{
          pageKey.currentState?.refresh();
        },
        child: PaginatedListView<Order>(
          key: pageKey,
          padding: EdgeInsets.symmetric(
            horizontal: AppSizer.getWidth(AppDimen.DASHBOARD_PADDING_HORZ),
            vertical: AppDimen.SCROLL_OFFSET_PADDING_VERT,
          ),
          initialItems: orderController.activeOrders,
          onDispose: (list){
            orderController.activeOrders=list as PageModel<Order>;
            // productController.recentProducts=list?.cast<Product>();
          },
          onFetchPage: (int page){
            return orderController.loadActiveOrders(page,);
          },
          separatorBuilder: (con,ind){
            return SizedBox(height: spacing,);
          },
          itemBuilder: (ind,item){
            return OrderContainer(order:item,onTap: (){
              AppNavigator.navigateTo(TrackOrderScreen(order: item,));
            },);
          },

        ),
      ),
    ));
  }
}
