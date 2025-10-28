import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tv_project/src/modules/home_module/models/all_room_token_model.dart';
import 'package:tv_project/src/modules/home_module/repository/home_repository.dart';

import '../../../core/utills/messagee_service.dart';

class HomeScreenController extends GetxController {
  // this will store all the room tokens
  RxList<PatientData> allRoomTokens = <PatientData>[].obs;

  Stream<DateTime> getTimeStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield DateTime.now();
    }
  }

  getAllRoomTokens() async {
    try {
      Map<String, Object> params = {
        "Branchid": "C8A30A86-C5E9-454B-AA52-28116B3BC74E",
        "RoomIds": "E0E8A055-9EFC-41FF-AE6B-7DDB308FCB29",
        "ActionById": "E0E8A055-9EFC-41FF-AE6B-7DDB308FCB29",
      };

      debugPrint('our params: $params');

      final res = await HomeRepository().getRoomAllTokens(params);

      /// Convert string to model using your existing function
      final parsedModel = allRoomTokenModelFromJson(res.toString());

      if (parsedModel.statusCode == 200 && parsedModel.data != null) {
        allRoomTokens.assignAll(parsedModel.data!);
        log('✅ Successfully parsed ${allRoomTokens.length} tokens');
        log('✅ THE DATA ${allRoomTokens[0]} ');
      } else {
        log('⚠️ API Error: ${parsedModel.errorMessage}');
      }
    } catch (e, s) {
      log('❌ Error while parsing room tokens: $e');
      log('Stacktrace: $s');
    }
  }
}
