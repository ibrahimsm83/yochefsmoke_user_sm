import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ycsh/controller/user/controllers.dart';
import 'package:ycsh/model/order.dart';
import 'package:ycsh/model/page_model.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/dashboard/order_history/order_detail.dart';
import 'package:ycsh/view/dashboard/track_order/track_order.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/order_items.dart';
import 'package:ycsh/widget/pagenation/paged_listview.dart';
import 'package:ycsh/widget/pagenation/paged_view.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {

  final GlobalKey<PagedViewState> pageKey=GlobalKey();

  final OrderController orderController=Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
   final double spacing= AppSizer.getHeight(15);
    return CustomBackground(child: Scaffold(
      appBar: DashboardAppbar(text:AppString.TEXT_ORDER_HISTORY,
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
          initialItems: orderController.orderHistory,
          onDispose: (list){
            orderController.orderHistory=list as PageModel<Order>;
            // productController.recentProducts=list?.cast<Product>();
          },
          onFetchPage: (int page){
            return orderController.loadOrders(page,);
          },
          separatorBuilder: (con,ind){
            return SizedBox(height: spacing,);
          },
          itemBuilder: (ind,item){
            return OrderContainer(order:item,onTap: (){
              AppNavigator.navigateTo(OrderDetailScreen(order: item));
            },);
          },

        ),
      ),
    ));
  }
}