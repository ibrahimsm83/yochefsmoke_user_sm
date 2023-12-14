import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:ycsh/controller/user/controllers.dart';
import 'package:ycsh/utils/navigation.dart';
import 'package:ycsh/utils/strings.dart';
import 'package:ycsh/widget/app_bar.dart';
import 'package:ycsh/widget/background.dart';
import 'package:ycsh/widget/button.dart';
import 'package:ycsh/widget/loader.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final DashboardController controller = Get.find<DashboardController>();

  @override
  void initState() {
    controller.loadAboutUs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
        child: Scaffold(
            appBar: DashboardAppbar(
              text: AppString.TEXT_ABOUT_US,
              leading: ButtonBack(
                onTap: () {
                  AppNavigator.pop();
                },
              ),
            ),
            body: GetBuilder<DashboardController>(
              builder: (cont) {
                return controller.about_us != null
                    ? SingleChildScrollView(
                      child: Html(
                          data: controller.about_us,
                        ),
                    )
                    : const ContentLoading();
              },
            )));
  }
}
