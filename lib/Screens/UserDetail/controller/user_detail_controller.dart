/**
 * Created by Jaimin on 20/03/24.
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaimin_starts_practical/Utils/Colors.dart';
import 'package:jaimin_starts_practical/Utils/CustomWidget.dart';

import '../../../ApiManager/ApiServices.dart';
import '../../../Model/UserDetailModel.dart';
import '../../../Utils/ConsoleLog.dart';
import '../../../Utils/Strings.dart';
import '../../Home/controller/home_controller.dart';

class UserDetailController extends GetxController {
  var isLoading = true.obs;
  var userDetail = Data().obs;
  final fireStore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();
  var nameController = TextEditingController().obs,
      emailController = TextEditingController().obs;

  void userDetails({var id}) async {
    isLoading.value = true;
    var response =
        await ApiServices.ApiProvider(0, url: '$userDetailEndPoint$id');
    try {
      var data = usersDetailModelFromJson(response);
      userDetail.value = data.data!;

      isLoading.value = false;
      Console.Log('userDetailsResponse', '');
    } catch (e) {
      isLoading.value = false;
      Console.Log('userDetailsError', e);
    }
  }

  void addData({String? name, email, image}) async {
    var data = {
      'name': name,
      'email': email,
      'image': image,
    };
    await fireStore.collection('userData').add(data);
    showSnackBar(isError: false, message: 'User Added successfully');
  }

  void updateData({String? name, email, image}) async {
    await fireStore
        .collection("userData")
        .where("name", isEqualTo: name)
        .get()
        .then((value) {
      for (var element in value.docs) {
        fireStore.collection('userData').doc(element.id).update({
          'name': nameController.value.text,
          'email': emailController.value.text,
          'image': image,
        }).then((_) {
          showSnackBar(isError: false, message: 'User updated successfully');
          Console.Log('userDetailsUpdated', '');
        }).catchError((error) {
          showSnackBar(isError: false, message: 'Error to update user');
          Console.Log('Fail to update User', error);
        });
      }
      Get.back();
    });
  }

  void deleteData({var name}) async {
    fireStore
        .collection("userData")
        .where("name", isEqualTo: name)
        .get()
        .catchError((error) => Console.Log('Fail to delete User', error))
        .then((value) {
      for (var element in value.docs) {
        fireStore.collection("userData").doc(element.id).delete().then((value) {
          print("Success!");
        });
      }
      showSnackBar(isError: false, message: 'User deleted successfully');
    });
  }

  void showUpdateDialog({var name, image}) {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Update User',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ),
        content: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text(
                    'Name :',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 45,
                      //width: 100,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: nameController.value,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                            bottom: 5,
                            left: 10,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Text(
                    'Email :',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 45,
                      //width: 100,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: emailController.value,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                            bottom: 5,
                            left: 10,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                text: 'Update',
                textColor: whiteColor,
                onTap: () {
                  updateData(name: name, image: image);
                },
                color: Colors.indigo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
