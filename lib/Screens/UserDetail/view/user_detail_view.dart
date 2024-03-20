/**
 * Created by Jaimin on 20/03/24.
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaimin_starts_practical/Utils/Colors.dart';
import 'package:jaimin_starts_practical/Utils/ConsoleLog.dart';
import 'package:jaimin_starts_practical/Utils/Extentions.dart';

import '../../../Utils/CustomWidget.dart';
import '../../../Utils/Height_Width.dart';
import '../../Home/controller/home_controller.dart';
import '../controller/user_detail_controller.dart';

class UserDetailView extends StatefulWidget {
  UserDetailView({super.key});

  @override
  State<UserDetailView> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView> {
  var controller = Get.put(UserDetailController());
  var isAdded;
  var homeController = Get.put(HomeController());

  @override
  void initState() {
    isAdded = Get.arguments['index'];
    Console.Log('indexValue', isAdded);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(
          text: 'User Detail',
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const CircularProgressIndicator().center()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  height50,
                  CachedNetworkImage(
                    imageUrl: controller.userDetail.value.avatar ?? '',
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      maxRadius: 55,
                      backgroundImage: CachedNetworkImageProvider(
                          controller.userDetail.value.avatar ?? ''),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ).center(),
                  height30,
                  CommonText(
                    text:
                        '${controller.userDetail.value.firstName} ${controller.userDetail.value.lastName}',
                    softWrap: true,
                    maxLine: 5,
                    textOverflow: TextOverflow.ellipsis,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                  CommonText(
                    text: controller.userDetail.value.email,
                    softWrap: true,
                    maxLine: 5,
                    textOverflow: TextOverflow.ellipsis,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  height30,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        homeController.userBoolList[isAdded]
                            ? shrink
                            : Expanded(
                                child: CustomButton(
                                  text: 'Add to Firebase',
                                  color: Colors.indigo,
                                  textColor: whiteColor,
                                  onTap: () {
                                    homeController.userBoolList[isAdded] = true;
                                    Console.Log('isAddedValue',
                                        homeController.userBoolList[isAdded]);
                                    controller.addData(
                                      name:
                                          '${controller.userDetail.value.firstName} ${controller.userDetail.value.lastName}',
                                      email: controller.userDetail.value.email,
                                      image: controller.userDetail.value.avatar,
                                    );
                                  },
                                ),
                              ),
                        width10,
                        Expanded(
                          child: CustomButton(
                            text: 'Update',
                            color: Colors.indigo,
                            textColor: whiteColor,
                            onTap: () {
                              controller.nameController.value.text =
                                  '${controller.userDetail.value.firstName} ${controller.userDetail.value.lastName}';
                              controller.emailController.value.text =
                                  controller.userDetail.value.email ?? '';
                              controller.showUpdateDialog(
                                  image: controller.userDetail.value.avatar,
                                  name:
                                      '${controller.userDetail.value.firstName} ${controller.userDetail.value.lastName}');
                            },
                          ),
                        ),
                        width10,
                        Expanded(
                          child: CustomButton(
                            text: 'Delete',
                            color: redColor,
                            textColor: whiteColor,
                            onTap: () {
                              homeController.userBoolList[isAdded] = false;
                              controller.deleteData(
                                  name:
                                      '${controller.userDetail.value.firstName} ${controller.userDetail.value.lastName}');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
