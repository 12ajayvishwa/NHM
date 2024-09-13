import 'package:flutter/material.dart';
import 'package:get/get.dart';



unauthorizedDialog() {
  // Get.snackbar(
  //     "Unauthorized User", "You are not authorized to access this url");
  // SessionManager.removeToken();
  // Get.offAllNamed(AppRoutes.loginScreen);
}

checkInternet() {
  Get.snackbar('No Internet', 'You are not connected to the internet',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      isDismissible: false,
      duration: const Duration(days: 1),
      icon: const Icon(
        Icons.wifi_off,
        color: Colors.white,
        size: 35,
      ),
      snackStyle: SnackStyle.GROUNDED,
      margin: EdgeInsets.zero,
      colorText: Colors.white);
}
