import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:tv_project/main.dart';
import 'package:tv_project/src/core/utills/messagee_service.dart';

import 'app_apis.dart';
import 'network/network_client.dart';

settingUpThings() async {
  //   fetching and storing JWT token
  print('✅CAME TO settingUpThings');

  fetchAndStoreJwtToken();
}

Future<void> fetchAndStoreJwtToken() async {
  try {
    print('✅CAME TO fetchAndStoreJwtToken');

    final dioNoInterceptor = Dio(); // no interceptors
    print('✅After dio interceptors');

    final response = await dioNoInterceptor.post(
      AppApis.getToken,
      data: {"Branchid": "C8A30A86-C5E9-454B-AA52-28116B3BC74E"},
    );

    print('✅After Calling APIs');

    debugPrint('Encrypted Response is : ${response.data}');

    final decryptedRespose = decodeBase64Plaintext(response.data['EncreptedData']);

    final decryptedJson = jsonDecode(decryptedRespose);

    debugPrint("decoded Response is : ${decryptedRespose.toLowerCase()}");

    // final data = response.data;
    final data = decryptedJson;
    // print("DATA TYPE OF THE data is : ${data.runtimeType}");
    // print("DATA TYPE OF THE STATUS CODE is : ${decryptedJson['statuscode']}");

    print("Available keys: ${decryptedJson.keys}");
    print("Raw statuscode value: ${decryptedJson['StatusCode']}");
    print("Type of statuscode: ${decryptedJson['StatusCode']?.runtimeType}");

    if (data['StatusCode'] == 'sucess') {
      await storeJwtToken(data['JWTToken']);
    } else {
      MessageService.showSnackBar(
        message: decryptedJson['Message'] ?? 'Error getting token',
        isSuccess: false,
      );
    }
  } catch (e) {
    MessageService.showSnackBar(message: "Error getting token", isSuccess: false);
  }
}

Future<void> storeJwtToken(String token) async {
  print('✅CAME TO STORE JWT token stored');

  await prefs.setString('token', token);
  print('✅ JWT token stored');
}
