/**
 * Created by Jaimin on 20/03/24.
 */
import 'package:get/get.dart';

import '../../../ApiManager/ApiServices.dart';
import '../../../Model/UserDetailModel.dart';
import '../../../Model/UsersModel.dart';
import '../../../Utils/ConsoleLog.dart';
import '../../../Utils/Strings.dart';
import '../../UserDetail/controller/user_detail_controller.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var userList = <User>[].obs;
  var detailController = Get.put(UserDetailController());
  var userBoolList = <bool>[].obs;

  @override
  void onInit() {
    loadUsers();
    super.onInit();
  }

  void loadUsers() async {
    var response = await ApiServices.ApiProvider(0, url: userEndPoint);
    try {
      var data = usersModelFromJson(response);
      userList.value = data.data!;
      userBoolList.value = List.generate(data.data!.length, (index) => false);
      isLoading.value = false;
      Console.Log('loadUsersResponse', '');
    } catch (e) {
      isLoading.value = false;
      Console.Log('loadUsersError', e);
    }
  }
}
