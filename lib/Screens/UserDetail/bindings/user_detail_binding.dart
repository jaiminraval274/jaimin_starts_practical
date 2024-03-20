/**
 * Created by Jaimin on 20/03/24.
 */
import 'package:get/get.dart';

import '../controller/user_detail_controller.dart';

class UserDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDetailController>(() => UserDetailController());
  }
}
