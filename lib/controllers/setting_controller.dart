// ignore_for_file: avoid_print
import 'dart:convert';
import '../../core/constants/api_network.dart';
import '../../core/constants/app_export.dart';
import '../../core/constants/session_manager.dart';
import '../../core/routes/app_routes.dart';
import '../../data/apiClient/api_client.dart';
import 'package:http/http.dart' as http;
import '../../data/apiClient/http_response.dart';
import '../../utils/custom_toast.dart';
import '../../widgets/image_picker.dart'; 

class SettingController extends GetxController {
  final rxRequestStatus = Status.success.obs;
  NetworkHttpServices api = NetworkHttpServices();
  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());

//final settingList = SettingModel().obs;

  // Registration Details
  final name = TextEditingController().obs;
  final designation = TextEditingController().obs;
  final editPhone = TextEditingController().obs;
  final registrationNo = TextEditingController().obs;
  final experience = TextEditingController().obs;
  final specialization = TextEditingController().obs;
  final isEmailChecked = false.obs;
  final isPasswordChecked = false.obs;
  final editEmail = TextEditingController().obs;
  final currentPassword = TextEditingController().obs;
  final newPassword = TextEditingController().obs;
  final confirmPassword = TextEditingController().obs;

  // Contact And Support
  final contactName = TextEditingController().obs;
  final contactPhoneNo = TextEditingController().obs;
  final contactEmail = TextEditingController().obs;
  final contactMessage = TextEditingController().obs;
  final address = TextEditingController().obs;
  final description = TextEditingController().obs;

  contactAndSupport() async {
    rxRequestStatus.value = Status.loading;
    // ignore: empty_catches
    try {} catch (e) {}
  }

  updateProfile() async {
    rxRequestStatus.value = Status.loading;

    var f = imagePickerController.result != null
        ? [
            await http.MultipartFile.fromPath(
                'avatar', imagePickerController.result!.path)
          ]
        : null;

    var file = imagePickerController.result != null ? f : null;
    print(file);
    var payload = {
      "email": editEmail.value.text,
      "name": name.value.text,
      'designation': designation.value.text,
      'phone': editPhone.value.text,
    };
    printInfo(info: payload.toString());
    try {
      var value =
          await api.formData(ApiNetwork.updateProfile, file, payload, 'PUT');
      if (value['success'] == true) {
        var jsonData = json.encode(value['payload']);

        await SessionManager.setUser(jsonData);
        rxRequestStatus.value = Status.success;
        showSuccessToast(toast, value['message']);
        Get.offAllNamed(
          AppRoutes.PROFILE,
          // arguments: SessionManager.getUserTypeId() != "3" ? 3 : 2,
        );
      } else {
        rxRequestStatus.value = Status.error;
        showErrorToast(
          toast,
          value['message'],
        );
      }
    } catch (e) {
      rxRequestStatus.value = Status.error;
      showErrorToast(
        toast,
        e.toString(),
      );
    }
  }

  logout() async {
    rxRequestStatus.value = Status.loading;
    try {
      var value = await api.get(ApiNetwork.logout);
      if (value['code'] == 200) {
        await SessionManager.removeToken();
        Get.offAllNamed(AppRoutes.LOGIN);
        showSuccessToast(toast, 'Logout Successfully');
      } else {
        rxRequestStatus.value = Status.error;
        showErrorToast(toast, value['message']);
      }
    } catch (e) {
      rxRequestStatus.value = Status.error;
      showErrorToast(toast, e.toString());
    }
  }
}
