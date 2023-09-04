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

  Order? _order;


  Order? get order => _order;

  Future<bool> addProductToCart(Product product,int quantity,{Map<String,ProductSideline>
    sidelines=const {}, Map<String,ProductVariant> varients=const {} }) async{
    AppLoader.showLoader();
    bool status=false;
    Order? order=await orderProvider.addToCart(dashboardController.user.accesstoken!,
        product, quantity,sidelines: sidelines.values.toList(),
        varients: varients.values.toList());
    AppLoader.dismissLoader();
    if(order!=null){
      status=true;
     // _order=order;
      _order?.subtotal=order.subtotal;
      _order?.total=order.total;
      _order?.discount=order.discount;
    }
    return status;
  }

  Future<bool> deleteProduct(Product product,) async{
    AppLoader.showLoader();
    bool status=false;
    Order? order=await orderProvider.deleteProduct(dashboardController.user.accesstoken!,
        _order!.id!,product.detail_id!,);
    AppLoader.dismissLoader();
    if(order!=null){
      status=true;
      _order!.products.remove(product);
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
    _order=null;
    update();
  }

  Future<void> postOrder(Address? address,{CreditCard? card}) async{
    if(address!=null) {
      AppLoader.showLoader();
      bool status = await orderProvider.postOrder(
          dashboardController.user.accesstoken!,order!.id!,address.id!,
          card_id: card?.id);
      AppLoader.dismissLoader();
      if(status){
        clearCart();
        AppNavigator.pop();
      }
    }
    else{
      AppMessage.showMessage("Please select address");
    }
  }

}