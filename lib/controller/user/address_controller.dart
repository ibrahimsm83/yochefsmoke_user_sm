import 'package:get/get.dart';
import 'package:ycsh/controller/user/controllers.dart';
import 'package:ycsh/model/address.dart';
import 'package:ycsh/service/repositories/address_provider.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/navigation.dart';

import '../../model/location.dart';

class AddressController extends GetxController{

  final AddressProvider addressProvider=AddressProvider();
  final DashboardController dashboardController=Get.find<DashboardController>();

  List<Address>? _addresses;

  Address? _defaultAddress;


  Address? get defaultAddress => _defaultAddress;

  List<Address>? get addresses => _addresses;

  void createAddress(String title,String city,String state,String country,
      String zipcode,{Location? location}) async{
    AppLoader.showLoader();
    bool status=await addressProvider.addAddress(dashboardController.user.accesstoken!,
        title, city, state, country, zipcode,location: location);
    AppLoader.dismissLoader();
    if(status){
      _addresses=null;
      update();
      loadAllAddresses();
      AppNavigator.pop();
    }
  }

  void editAddress(Address address,String title,String city,String state,String country,
      String zipcode,{Location? location}) async{
    AppLoader.showLoader();
    Address? add=await addressProvider.updateAddress(dashboardController.user.accesstoken!,
       address.id!, title, city, state, country, zipcode,location: location);
    AppLoader.dismissLoader();
    if(add!=null){
      address.title=add.title;
      address.city=add.city;
      address.state=add.state;
      address.country=add.country;
      address.postal_code=add.postal_code;
      address.location=add.location;
      update();
      AppNavigator.pop();
    }
  }

  void setDefaultAddress(Address address) async{
    AppLoader.showLoader();
    bool status=await addressProvider.addDefaultAddress(dashboardController.user.accesstoken!,
        address.id!);
    AppLoader.dismissLoader();
    if(status){
      _defaultAddress=address;
      update();
    }
  }

  Future<bool> deleteAddress(Address address,) async{
    AppLoader.showLoader();
    bool status=await addressProvider.deleteAddress(dashboardController.user.accesstoken!,
        address.id!);
    AppLoader.dismissLoader();
    if(status){
      _addresses?.remove(address);
      update();
    }
    return status;
  }

  Future<void> loadAllAddresses() async{
  //  _defaultAddress=null;
    await addressProvider.getAddresses(dashboardController.user.accesstoken!,onTask: (add){
      if(add.isDefault){
        _defaultAddress=add;
      }
    }).then((list) {
      if (list != null) {
        _addresses=list;
        update();
      }
    });
  }

  Future<void> loadDefaultAddresses() async{
    await addressProvider.getDefaultAddress(dashboardController.user.accesstoken!,)
        .then((list) {
          if(list!=null) {
            _defaultAddress = list;
            update();
          }
    });
  }

}