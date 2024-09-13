import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/api_network.dart';
import '../../../../core/constants/session_manager.dart';
import '../../../../data/apiClient/api_client.dart';
import '../../../../data/apiClient/http_response.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../notification/notification_service.dart';
import '../../../../utils/custom_toast.dart';

/// A controller class for the Iphone14Pro101Screen.
///
/// This class manages the state of the Iphone14Pro101Screen, including the
/// current iphone14Pro101ModelObj
class LoginVerificationController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();
  Rx<TextEditingController> otpController = TextEditingController().obs;
  final rxRequestStatus = Status.success.obs;
  bool isResendAgain = false;
  // ignore: unused_field
  late Timer _timer;
  RxInt start = 30.obs;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        // ignore: unrelated_type_equality_checks
        if (start == 0) {
          timer.cancel();
        } else {
          start--;
        }
      },
    );
  }

  loginVerification(email) async {
    // print(deviceToken);
    var payload = {
      "otp": otpController.value.text.toString(),
      "email": email,
      "fcm_token": deviceToken.toString(),
    };
    if (kDebugMode) {
      print("xyx $payload");
    }
    // return;

    rxRequestStatus.value = Status.loading;
    try {
      var value = await api.post(ApiNetwork.loginVerify, payload, false);
      if (value['success'] == true) {
        var jsonData = json.encode(value['payload']);
        rxRequestStatus.value = Status.success;
        await SessionManager.setToken(value['payload']['token']['token']);
        await SessionManager.setUser(jsonData);
        await SessionManager.setUserId(value["payload"]["id"].toString());
        await SessionManager.setUserTypeId(
            value["payload"]["user_type_id"].toString());
        await SessionManager.setHospitalId(
            value["payload"]["hospital_id"].toString());
        Get.offAllNamed(AppRoutes.DASHBOARD);
      } else if (value['message'] == 'Invalid OTP or OTP expired') {
        showErrorToast(toast, value['message']);
        // customFlutterToast(
        //     backgroundColor: Colors.red, msg: 'Invalid OTP or OTP expired');
        rxRequestStatus.value = Status.error;
      }
    } catch (e) {
      showErrorToast(toast, e.toString());
      rxRequestStatus.value = Status.error;
    }
  }
}
