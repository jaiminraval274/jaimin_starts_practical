/**
 * Created by Jaimin on 20/03/24.
 */

import 'dart:convert';
import 'dart:developer' as dev;

import 'package:http/http.dart' as http;

import '../Utils/Strings.dart';

class ApiServices {
  static Future ApiProvider(int isPost,
      {String? url, Map<String, dynamic>? body}) async {
    http.Response? response;

    var apiURL = '$BASEURL$url';

    dev.log('Api : $apiURL');

    try {
      if (isPost == 0) {
        response = await http.get(Uri.parse(apiURL));
      } else if (isPost == 1) {
        response = await http.post(Uri.parse(apiURL), body: body);
      } else if (isPost == 2) {
        response = await http.put(Uri.parse(apiURL), body: jsonEncode(body!));
      }

      switch (response!.statusCode) {
        case 200:
          return response.body;
        case 400:
          dev.log('Bed Request Error');
          throw Exception(
              "The server cannot or will not process the request due to an apparent client error (e.g., malformed request syntax, size too large, invalid request message framing, or deceptive request routing).  ==> ${response.statusCode}");
        case 401:
          dev.log(
              'The user does not have valid authentication credentials for the target resource');
          throw Exception(
              "The user does not have valid authentication credentials for the target resource ==> ${response.statusCode}");
        case 404:
          dev.log('Page Not Found');
          throw Exception("Page Not Found ==> ${response.statusCode}");
        case 500:
          dev.log('Internal Server Error');
          //showWarningSnackBar(isFlat: false, message: 'Internal Server Error');
          throw Exception("Internal Server Error ==> ${response.statusCode}");

        case 102:
          dev.log('Internal Server Error');
          throw Exception("Internal Server Error ==> ${response.statusCode}");
      }
    } catch (error) {
      dev.log("Error From the Web services  ===> $error");
      return Exception("Something went wrong. Please try again later.");
    }
  }
}
