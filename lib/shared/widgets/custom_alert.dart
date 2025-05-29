import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool?> showCustomAlert({
  String title = '',
  String message = '',
  String buttonText = 'OK',
  bool isError = false,
  bool isAlert = false,
  bool isConfirm = false,
}) async {
  late Timer timer;

  // Start the timer to auto-close after 3 seconds
  if (!isConfirm) {
    timer = Timer(const Duration(seconds: 3), () {
      if (Get.isDialogOpen ?? false) {
        Get.back(result: true); // Close the dialog
      }
    });
  }

  // Show the dialog and wait for it to close
  return Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Column(
          children: [
            if (isError)
              const Icon(Icons.error, color: Colors.red, size: 50)
            else if (isAlert)
              const Icon(Icons.warning_rounded,
                  color: Colors.orangeAccent, size: 50)
            else if (isConfirm)
              const Icon(Icons.help_outlined, color: Colors.blue, size: 50)
            else
              const Icon(Icons.check_circle, color: Colors.green, size: 50),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        actions: [
          !isConfirm
              ? Center(
                  child: SizedBox(
                    width: 90,
                    child: ElevatedButton(
                      onPressed: () {
                        timer.cancel();
                        Get.back(); // Manual close
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: isError
                            ? Colors.red
                            : isAlert
                                ? Colors.orangeAccent
                                : Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(buttonText),
                    ),
                  ),
                )
              : Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 90,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back(result: false); // Manual close
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('No'),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      SizedBox(
                        width: 90,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back(result: true); // Manual close
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Yes'),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
      barrierDismissible: false);
}
