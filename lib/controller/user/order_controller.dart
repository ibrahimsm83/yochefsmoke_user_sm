import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ycsh/controller/user/dashboard_controller.dart';
import 'package:ycsh/model/interface.dart';
import 'package:ycsh/model/order.dart';
import 'package:ycsh/model/page_model.dart';
import 'package:ycsh/model/stock.dart';
import 'package:ycsh/service/repositories/order_provider.dart';

class OrderController extends GetxController with SocketMessageHandler{

  PageModel<Order>? _orderHistory;
  PageModel<Stock>? _stockHistory;
  PageModel<Order>? _activeOrders;

  final DashboardController controller=Get.find<DashboardController>();

  final OrderProvider orderProvider=OrderProvider();

  PageModel<Order>? get orderHistory => _orderHistory;
  PageModel<Order>? get activeOrders => _activeOrders;

  PageModel<Stock>? get stockHistory => _stockHistory;

  set stockHistory(PageModel<Stock>? value) {
    _stockHistory = value;
  }


  set activeOrders(PageModel<Order>? value) {
    _activeOrders = value;
  }

  set orderHistory(PageModel<Order>? value) {
    _orderHistory = value;
  }

  Future<PageModel<Order>?> loadOrders(int page,){
    return orderProvider.getOrderHistory(controller.user.accesstoken!,page: page,);
  }

  Future<PageModel<Order>?> loadActiveOrders(int page,){
    return orderProvider.getActiveOrders(controller.user.accesstoken!,page: page,);
  }

  Future<Order?> loadOrderDetails(String order_id) {
    return orderProvider.getOrderDetails(controller.user.accesstoken!, order_id);
  }

  Future<PageModel<Stock>?> loadStocks(String binding_id,int page,) {
    return orderProvider.getRiderStocks(
      controller.user.accesstoken!,binding_id,
      page: page,
    );
  }

/*  Future<void> loadActiveOrders({bool set=false}) async{
    //  _defaultAddress=null;
    if(set){
      _activeOrders=null;
      update();
    }
    await orderProvider.getActiveOrders(controller.user.accesstoken!,).then((list) {
      if (list != null) {
        _activeOrders=list;
        update();
      }
    });
  }*/

}