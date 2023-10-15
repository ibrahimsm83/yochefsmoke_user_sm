import 'package:get/get.dart';
import 'package:ycsh/controller/user/dashboard_controller.dart';
import 'package:ycsh/model/payment.dart';
import 'package:ycsh/service/repositories/payment_provider.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/navigation.dart';

class PaymentController extends GetxController{

  final PaymentProvider paymentProvider=PaymentProvider();

  final DashboardController dashboardController=Get.find<DashboardController>();

  List<CreditCard>? _cards;

  CreditCard? _defaultCard;


  List<CreditCard>? get cards => _cards;


  CreditCard? get defaultCard => _defaultCard;

  void createCard(String card_num,String exp_month,String exp_year,String cvv,) async{
    AppLoader.showLoader();
    bool status=await paymentProvider.addCard(dashboardController.user.accesstoken!,
        card_num, exp_month, exp_year, cvv);
    AppLoader.dismissLoader();
    if(status){
      _cards=null;
      update();
      loadAllCards();
      AppNavigator.pop();
    }
  }

  Future<bool> deleteCard(CreditCard card,) async{
    AppLoader.showLoader();
    bool status=await paymentProvider.deleteCard(dashboardController.user.accesstoken!,
        card.id!);
    AppLoader.dismissLoader();
    if(status){
      _cards?.remove(card);
      update();
    }
    return status;
  }

  Future<void> loadAllCards() async{
   // _defaultCard=null;
    await paymentProvider.getCards(dashboardController.user.accesstoken!,onTask: (add){
      if(add.isDefault){
        _defaultCard=add;
      }
    }).then((list) {
      if (list != null) {
        _cards=list;
        update();
      }
    });
  }

  void setDefaultCard(CreditCard address) async{
    AppLoader.showLoader();
    bool status=await paymentProvider.addDefaultCard(dashboardController.user.accesstoken!,
        address.id!);
    AppLoader.dismissLoader();
    if(status){
      _defaultCard=address;
      update();
    }
  }

  Future<void> loadDefaultCard() async{
    await paymentProvider.getDefaultCard(dashboardController.user.accesstoken!,)
        .then((list) {
      if(list!=null) {
        _defaultCard = list;
      }
      else{
        _defaultCard=CreditCard();
      }
      update();
    });
  }

}