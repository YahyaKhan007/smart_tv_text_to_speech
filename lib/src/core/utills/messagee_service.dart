import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_elements/custom_text.dart';

class MessageService {
  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  void showTopSnackBar(String message, {bool isSuccess = true, String title = 'remember'}) {
    Get.snackbar(
      title, // Title (optional)
      message,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      // Show at top
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      duration: const Duration(seconds: 3),
    );
  }

  static void showSnackBar({
    required String message,
    required bool isSuccess,
    Duration? snackBarDuration,
  }) {
    final SnackBar snackBar;
    if (isSuccess) {
      snackBar = SnackBar(
        duration: snackBarDuration ?? const Duration(seconds: 3),
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: CustomText(text: message, textColor: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      );
    } else {
      snackBar = SnackBar(
        duration: snackBarDuration ?? const Duration(seconds: 3),
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: CustomText(text: message, textColor: Colors.white, maxLines: 3),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      );
    }

    messengerKey.currentState?.showSnackBar(snackBar);
  }
}
