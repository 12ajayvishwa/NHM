// ignore_for_file: avoid_print
import 'package:pvi_nhm/data/model/user_list_model.dart';

import '../core/constants/app_export.dart';
import '../core/constants/api_network.dart';
import '../core/routes/app_routes.dart';
import '../data/apiClient/api_client.dart';
import '../data/apiClient/http_response.dart';
import '../utils/custom_toast.dart';

class AuthController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController registrationNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String hospitalId = "";
  String userTypeId = "";
  //Gender gender = Gender.male;

  Rx<bool> agreementText = false.obs;
  final rxRequestStatus = Status.success.obs;
  var  isPasswordVisible = true.obs;
  int? accountType;
  togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

 

  login() async {
    var payload = {
      "email": emailController.value.text,
      "password": passwordController.value.text,
      
      'logout_all': 'true',
    };
    //print(payload);
    rxRequestStatus.value = Status.loading;
    try {
      var value = await api.post(ApiNetwork.login, payload, false);
      print(value);
      if (value['success'] == true) {
        print(value["success"]);

        Get.offAndToNamed(AppRoutes.LOGIN_VERIFICATION,
            arguments: emailController.value.text);
        showSuccessToast(toast, value["message"]);

        rxRequestStatus.value = Status.success;
      } else {
        showErrorToast(toast, value["message"]);
        rxRequestStatus.value = Status.error;
      }
    } catch (e) {
      showErrorToast(toast, e.toString());

      rxRequestStatus.value = Status.error;
    }
  }

  signUp(gender) async {
    var payload = {
      "name": nameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "registration_no": registrationNoController.text,
      "user_type_id": "3",
      //"password": "123456",
      "address": addressController.text,
      "gender": gender,
      //  "active": true,
      // "specialization_id": specializationId,
      "role": "doctor",
      "hospital_id": hospitalId
    };
    print(payload);
    rxRequestStatus.value = Status.loading;
    try {
      var value = await api.post(ApiNetwork.signUp, payload, false);
      print(value);
      if (value['success'] == true) {
        print(value["success"]);
        dataClear();
        Get.offAllNamed(AppRoutes.LOGIN, arguments: emailController.value.text);
        showSuccessToast(toast, value["message"]);
        rxRequestStatus.value = Status.success;
      } else {
        showSuccessToast(toast, value["message"]);
        rxRequestStatus.value = Status.error;
      }
    } catch (e) {
      showErrorToast(toast, e.toString());
      rxRequestStatus.value = Status.error;
    }
  }

  dataClear() {
    nameController.clear();
    registrationNoController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
    accountType = null;
  }
}
