import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ycsh/controller/user/controllers.dart';
import 'package:ycsh/model/address.dart';
import 'package:ycsh/service/location.dart';
import 'package:ycsh/service/repositories/address_provider.dart';
import 'package:ycsh/service/repositories/order_provider.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/navigation.dart';

import '../../model/location.dart';

class ProfileController extends GetxController{

  final AddressProvider addressProvider=AddressProvider();
  final OrderProvider orderProvider=OrderProvider();
  final DashboardController dashboardController=Get.find<DashboardController>();

  List<Address>? _addresses;

  Address? _defaultAddress;

  int _orderCount=0;


  Address? get defaultAddress => _defaultAddress;

  List<Address>? get addresses => _addresses;


  int get orderCount => _orderCount;

  void createAddress(String title,String city,String state,String country,
      String zipcode,{Location? location}) async{
    AppLoader.showLoader();
    Address? address=await addressProvider.addAddress(dashboardController.user.accesstoken!,
        title, city, state, country, zipcode,location: location,
        isDefault: (_addresses==null || _addresses!.isEmpty));
    AppLoader.dismissLoader();
    if(address!=null){
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
        .then((list) async{
          if(list!=null) {
            _defaultAddress = list;
          }
          else{
            var add=dashboardController.user.address!;
            var loc=await LocationService().geoCode(LatLng(add.location!.latitude,
                add.location!.longitude));

            Address? address=await addressProvider.addAddress(dashboardController.user.accesstoken!,
                "Home", loc.city, loc.state, loc.country, loc.postalCode,
              location: loc,isDefault: true,);
            if(address!=null){
              _defaultAddress=address;
            }
           // _defaultAddress=dashboardController.user.address;
          }
          update();
    });
  }

  Future<void> loadOrderCount() async{
    await orderProvider.getOrderHistory(dashboardController.user.accesstoken!,)
        .then((list) {
      if(list!=null) {
        _orderCount=list.total_items;
        update();
      }
    });
  }

}