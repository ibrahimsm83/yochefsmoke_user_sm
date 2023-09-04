import 'package:get/get.dart';
import 'package:ycsh/controller/user/dashboard_controller.dart';
import 'package:ycsh/model/order.dart';
import 'package:ycsh/model/page_model.dart';
import 'package:ycsh/service/repositories/order_provider.dart';

class OrderController extends GetxController{

  PageModel<Order>? _orderHistory;

  final DashboardController controller=Get.find<DashboardController>();

  final OrderProvider orderProvider=OrderProvider();

  PageModel<Order>? get orderHistory => _orderHistory;

  set orderHistory(PageModel<Order>? value) {
    _orderHistory = value;
  }

  Future<PageModel<Order>?> loadOrders(int page,){
    return orderProvider.getOrderHistory(controller.user.accesstoken!,page: page,);
  }

}