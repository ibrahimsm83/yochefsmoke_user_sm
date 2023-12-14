import 'package:get/get.dart';
import 'package:ycsh/controller/user/controllers.dart';
import 'package:ycsh/model/address.dart';
import 'package:ycsh/model/order.dart';
import 'package:ycsh/model/payment.dart';
import 'package:ycsh/model/product.dart';
import 'package:ycsh/service/repositories/order_provider.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/navigation.dart';

class CartController extends GetxController{

  final OrderProvider orderProvider=OrderProvider();

  final DashboardController dashboardController=Get.find<DashboardController>();

  final ProductController productController=Get.find<ProductController>();

  Order? _order;


  Order? get order => _order;

  Future<bool> addProductToCart(Product product,int quantity, {
    List<ProductSideline> sidelines=const [],
    List<ProductVariant> varients=const [],
    bool checkvars=false,
  }) async{
    bool status=false;
    if(!checkvars || checkVarients(product,quantity, varients)) {
      AppLoader.showLoader();
      Order? order = await orderProvider.addToCart(
          dashboardController.user.accesstoken!,
          product, quantity, sidelines: sidelines,
          varients: varients);
      AppLoader.dismissLoader();
      if (order != null) {
        status = true;
        // _order=order;
        _order?.products = order.products;
        _order?.subtotal = order.subtotal;
        _order?.total = order.total;
        _order?.discount = order.discount;
      }
    }
    return status;
  }

  bool checkVarients(Product prod,int quantity,List<ProductVariant> sel_varients){
    bool allow=false;
    List<ProductVariant>? vars=productController.getVarients(prod.id!);
    if(vars!=null) {
      if (vars.isEmpty) {
        allow = true;
      }
      else {
        int count = 0;
        sel_varients.forEach((element) {
          count += element.quantity;
        });
        if (count == quantity) {
          allow=true;
        }
        else {
          AppMessage.showMessage("You must select valid varients");
        }
      }
    }
    return allow;
  }

  Future<bool> deleteProduct(Product product,) async{
    AppLoader.showLoader();
    bool status=false;
    Order? order=await orderProvider.deleteProduct(dashboardController.user.accesstoken!,
        _order!.id!,product.detail_id!,);
    AppLoader.dismissLoader();
    if(order!=null){
      status=true;
      //_order!.products.remove(product);
      _order!.products=order.products;
      _order!.subtotal=order.subtotal;
      _order!.total=order.total;
      _order!.discount=order.discount;
      update();
    }
    return status;
  }

  Future<void> loadCurrentOrder() async{
    await orderProvider.getCurrentOrder(dashboardController.user.accesstoken!,).then((list) {
      if (list != null) {
        _order=list;
        update();
      }
    });
  }

  void clearCart(){
   // _order=null;
    _order?.products.clear();
    update();
  }

  Future<void> postOrder(Address? address,{CreditCard? card}) async{
    if(address!=null) {
      if(card!=null && card.id!=null) {
        AppLoader.showLoader();
        bool status = await orderProvider.postOrder(
            dashboardController.user.accesstoken!, order!.id!, address.id,
            card_id: card?.id);
        AppLoader.dismissLoader();
        if (status) {
          clearCart();
          AppNavigator.pop();
        }
      }
      else{
        AppMessage.showMessage("Please select a card");
      }
    }
    else{
      AppMessage.showMessage("Please select address");
    }
  }

}