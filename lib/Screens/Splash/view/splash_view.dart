/**
 * Created by Jaimin on 20/03/24.
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaimin_starts_practical/Utils/Extentions.dart';

import '../../../Utils/CustomWidget.dart';
import '../../../Utils/Height_Width.dart';
import '../controller/splash_controller.dart';

class SplashView extends StatelessWidget {
   SplashView({super.key});
var controller =Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FlutterLogo(
            size: 100,
          ).center(),
          height20,
          CommonText(
            text: 'Jaimin Practical',
            fontSize: 20,
            textColor: Colors.black,
          ).center(),
          height20,
          const CircularProgressIndicator().center(),
        ],
      ),
    );
  }
}
