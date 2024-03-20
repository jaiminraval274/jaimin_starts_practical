/**
 * Created by Jaimin on 20/03/24.
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Colors.dart';
import 'Height_Width.dart';
import 'Strings.dart';
import 'bounce_widget.dart';

class CommonText extends StatelessWidget {
  String? text;
  Color? textColor;
  double? fontSize;
  int? maxLine;
  FontWeight? fontWeight;
  TextOverflow? textOverflow;
  bool? softWrap;

  CommonText({
    super.key,
    this.text,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.maxLine,
    this.textOverflow,
    this.softWrap,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      maxLines: maxLine,
      overflow: textOverflow,
      softWrap: softWrap,
    );
  }
}

class CustomButton extends StatelessWidget {
  String? text;
  Function()? onTap;
  Color? color, textColor;
  double? height, width;

  CustomButton({
    super.key,
    this.text,
    this.onTap,
    this.height = 55,
    this.width = 100,
    this.color = Colors.indigo,
    this.textColor = Colors.indigo,
  });

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onPress: onTap,
      child: Container(
        height: height,
        width: Get.width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: CommonText(
          text: text!,
          textColor: textColor,
        ),
      ),
    );
  }
}

void showSnackBar({bool? isError, var message}) {
  if (isError!) {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: whiteColor,
            insetPadding: const EdgeInsets.only(left: 20, right: 20),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: SizedBox(
              width: 350,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  height15,
                  const FlutterLogo(),
                  height5,
                  CommonText(
                    text: 'Error',
                    fontSize: 16,
                  ),
                  height5,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: CommonText(
                      text: message,
                      fontSize: 13,
                    ),
                  ),
                  height10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: CustomButton(
                      text: 'Ok',
                      onTap: Get.back,
                    ),
                  ),
                  height15,
                ],
              ),
            ),
          );
        });
  } else {
    Get.snackbar(
      isError == true ? 'failed' : 'success',
      message,
      icon: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5),
        child: Icon(
          isError == true ? Icons.cancel : Icons.done,
          color: isError == true ? Colors.red : Colors.green,
        ),
      ),
      backgroundColor: whiteColor,
      snackPosition: SnackPosition.BOTTOM,
      borderColor: isError == true ? Colors.red : Colors.green,
      borderWidth: 4,
      colorText: isError == true ? Colors.red : Colors.green,
      duration: Duration(seconds: isError == true ? 3 : 2),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
    );
  }
}
