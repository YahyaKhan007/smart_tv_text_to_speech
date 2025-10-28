import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../main.dart';

import '../app_apis.dart';
import '../utills/messagee_service.dart';
import 'network_client.dart';

Future<void> fetchAndStoreJwtToken() async {
  try {
    final dioNoInterceptor = Dio(); // no interceptors
    final response = await dioNoInterceptor.post(
      AppApis.getToken,
      data: {
        "Client_Id": "0718b05f-252b-4eee-8793-0b221de1a792",
        "Client_Secret": "2e84b57a-1b73-4e20-b072-4e67403bf66a",
      },
    );

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
