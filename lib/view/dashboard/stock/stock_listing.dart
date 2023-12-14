import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ycsh/controller/user/order_controller.dart';
import 'package:ycsh/model/page_model.dart';
import 'package:ycsh/model/stock.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/pagenation/paged_listview.dart';
import 'package:ycsh/widget/pagenation/paged_view.dart';
import 'package:ycsh/widget/stock_items.dart';

class StockListingScreen extends StatefulWidget {

  final String binding_id;
  const StockListingScreen({Key? key,required this.binding_id,}) : super(key: key);

  @override
  State<StockListingScreen> createState() => _StockListingScreenState();
}

class _StockListingScreenState extends State<StockListingScreen> {

  final GlobalKey<PagedViewState> pageKey=GlobalKey();

  final OrderController orderController=Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    final double spacing= AppSizer.getHeight(10);
    return CustomBackground(child: Scaffold(
      appBar: DashboardAppbar(text:AppString.TEXT_RIDER_STOCK,
        leading: ButtonBack(onTap: (){
          AppNavigator.pop();
        },),),
      body: RefreshIndicator(
        onRefresh: () async{
          pageKey.currentState?.refresh();
        },
        child: PaginatedListView<Stock>(
          key: pageKey,
          padding: EdgeInsets.symmetric(
            horizontal: AppSizer.getWidth(AppDimen.DASHBOARD_PADDING_HORZ),
            vertical: AppDimen.SCROLL_OFFSET_PADDING_VERT,
          ),
/*          initialItems: orderController.stockHistory,
          onDispose: (list){
            orderController.stockHistory=list as PageModel<Stock>;
          },*/
          onFetchPage: (int page){
            return orderController.loadStocks(widget.binding_id,page,);
          },
          separatorBuilder: (con,ind){
            return SizedBox(height: spacing,);
          },
          itemBuilder: (ind,item){
            return StockContainer(stock:item,);
          },

        ),
      ),
    ));
  }
}