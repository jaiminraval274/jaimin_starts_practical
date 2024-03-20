/**
 * Created by Jaimin on 20/03/24.
 */
import 'package:get/get.dart';

import '../controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
