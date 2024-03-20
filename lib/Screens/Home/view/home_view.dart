/**
 * Created by Jaimin on 20/03/24.
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jaimin_starts_practical/Utils/ConsoleLog.dart';
import 'package:jaimin_starts_practical/Utils/Extentions.dart';

import '../../../Utils/Colors.dart';
import '../../../Utils/CustomWidget.dart';
import '../../../Utils/Height_Width.dart';
import '../../../Utils/Strings.dart';
import '../../../routes/app_pages.dart';
import '../controller/home_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  var homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(
          text: 'Users',
        ),
      ),
      body: Obx(
        () => homeController.isLoading.value
            ? const CircularProgressIndicator().center()
            : ListView.builder(
                itemCount: homeController.userList.value.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    homeController.detailController.userDetails(
                        id: homeController.userList.value[index].id);
                    Console.Log('IsAdded', homeController.userBoolList[index]);
                    Get.toNamed(Routes.USERDETAIL, arguments: {
                      'index': index,
                    });
                  },
                  child: Container(
                    width: Get.width,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(2, 1),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              homeController.userList.value[index].avatar ?? '',
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            maxRadius: 55,
                            backgroundImage: CachedNetworkImageProvider(
                                homeController.userList.value[index].avatar ??
                                    ''),
                          ),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        width10,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text:
                                  '${homeController.userList.value[index].firstName ?? ""} ${homeController.userList.value[index].lastName ?? ""}',
                              fontSize: 16,
                            ),
                            height5,
                            CommonText(
                              text:
                                  homeController.userList.value[index].email ??
                                      '',
                              fontSize: 14,
                              textColor: Colors.grey,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
