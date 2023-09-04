import 'package:flutter/material.dart';
import 'package:ycsh/model/address.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/dashboard/address/add_address.dart';

class EditAddressScreen extends AddAddressScreen {

  final Address address;
  const EditAddressScreen({Key? key,required this.address,}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends AddAddressScreenState {

  @override
  EditAddressScreen get widget => super.widget as EditAddressScreen;

  @override
  String get screenTitle => AppString.TEXT_EDIT_ADDRESS;

  @override
  void onInit() {
    title.text=widget.address.title!;
    postal_code.text=widget.address.postal_code!;
    city.text=widget.address.city!;
    state.text=widget.address.state!;
    country.text=widget.address.country!;
    location=widget.address.location;
  }

  @override
  String get btnText => AppString.TEXT_SAVE;

  @override
  void submit() {
    addressController.editAddress(widget.address, title.text, city.text,
        state.text, country.text, postal_code.text,location: location);
  }

}
