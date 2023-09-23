import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ycsh/controller/user/address_controller.dart';
import 'package:ycsh/model/address.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/asset_path.dart';
import 'package:ycsh/utils/constants.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/sizer.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/view/dashboard/address/add_address.dart';
import 'package:ycsh/view/dashboard/address/edit_address.dart';
import 'package:ycsh/widget/address_items.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/common.dart';
import 'package:ycsh/widget/loader.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final AddressController addressController = Get.find<AddressController>();

  @override
  void initState() {
    addressController.loadAllAddresses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double diameter = AppSizer.getHeight(50);
    return CustomBackground(
        child: Scaffold(
      floatingActionButton: CircularButton(
        icon: AssetPath.ICON_PLUS,
        bgColor: AppColor.THEME_COLOR_PRIMARY1,
        diameter: diameter,
        onTap: () {
          AppNavigator.navigateTo(AddAddressScreen());
        },
      ),
      appBar: DashboardAppbar(
        text: AppString.TEXT_ADDRESSES,
        leading: ButtonBack(
          onTap: () {
            AppNavigator.pop();
          },
        ),
      ),
      body: GetBuilder<AddressController>(builder: (cont) {
        final List<Address>? list = cont.addresses;
        return list != null
            ? (list.isNotEmpty
                ? ListView.separated(
                    padding: EdgeInsets.symmetric(
                        vertical: AppDimen.SCROLL_OFFSET_PADDING_VERT,
                        horizontal:
                            AppSizer.getWidth(AppDimen.DASHBOARD_PADDING_HORZ)),
                    itemCount: list.length,
                    itemBuilder: (con, ind) {
                      var add = list[ind];
                      bool isDefault=add.id == cont.defaultAddress?.id;
                      return ProfileAddressContainer(
                          address: add,
                          selected: isDefault,
                          onEdit: () {
                            AppNavigator.navigateTo(EditAddressScreen(
                              address: add,
                            ));
                          },
                          onDelete: (){
                            if(!isDefault) {
                              cont.deleteAddress(add);
                            }
                            else{
                              AppMessage.showMessage("Default address cannot be deleted");
                            }
                          },
                          onTap: (selected) {
                            if (!selected) {
                              cont.setDefaultAddress(add);
                            }
                          });
                    },
                    separatorBuilder: (con, ind) {
                      return SizedBox(
                        height: AppSizer.getHeight(15),
                      );
                    },
                  )
                : const NotFoundText())
            : const ContentLoading();
      }),
    ));
  }
}
