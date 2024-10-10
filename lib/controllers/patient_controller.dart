import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:pvi_nhm/controllers/user_controller.dart';
import 'package:pvi_nhm/data/model/patient_model.dart';
import '../core/constants/api_network.dart';
import '../core/constants/app_export.dart';
import '../core/routes/app_routes.dart';
import '../data/apiClient/api_client.dart';
import '../data/apiClient/http_response.dart';
import '../data/model/reassign_surgery_model.dart';
import 'auth_controller.dart';
import '../utils/custom_snackbar.dart';
import '../utils/custom_toast.dart';
import 'setting_controller.dart';

class PatientController extends GetxController {
  final rxRequestStatus = Status.success.obs;
  NetworkHttpServices api = NetworkHttpServices();
  SettingController settingController = Get.put(SettingController());
  AuthController authController = Get.put(AuthController());
  UserController userController = Get.put(UserController());

  //Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController name1Controller = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController blockController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController mpidController = TextEditingController();
  TextEditingController gravidaController = TextEditingController();
  TextEditingController parityController = TextEditingController();
  TextEditingController procedureController = TextEditingController();
  TextEditingController electiveSurgeryController = TextEditingController();
  TextEditingController nameOfAnesthetistController = TextEditingController();
  TextEditingController typeOfAnesthetistController = TextEditingController();
  TextEditingController palaceOfPostingController = TextEditingController();
  TextEditingController nameOfFacilityController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController addressTimeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String date = "";

  List<PatientModel> patientList = [];
  List<ReassignSurgeryModel> assignedSurgeryList = [];

  addPatient(verify, gender) async {
    print(verify);
    rxRequestStatus.value = Status.loading;
    var body = {
      "patient_name": nameController.text,
      "husband_name": name1Controller.text,
      "phone": phoneController.text,
      "age": ageController.text,
      "gender": gender,
      "village": villageController.text,
      "block": blockController.text,
      "district": districtController.text,
      "mpid": mpidController.text,
      "gravida": gravidaController.text,
      "parity": parityController.text,
      "procedure": procedureController.text,
      "elective_surgery": electiveSurgeryController.text,
      "address": addressTimeController.text,
      "doctor_id": userController.doctorId,
      "name_of_anesthetist": nameOfAnesthetistController.text,
      "type_of_anesthesia": typeOfAnesthetistController.text,
      "palace_of_posting": palaceOfPostingController.text,
      "approver_id": userController.approvalId,
      "name_of_facility": nameOfFacilityController.text,
      "status": "4",
      "date_time": date
    };
    print(body);
    try {
      var response = await api.post(ApiNetwork.createPatient, body, false);
      if (response["code"] == 200) {
        rxRequestStatus.value = Status.success;
        showSuccessToast(toast, response['message']);
        Get.offAllNamed(AppRoutes.DASHBOARD, arguments: [1, 0]);
      } else if (response["success"] == false) {
        rxRequestStatus.value = Status.error;
        showErrorToast(toast, response['message']);
      }
    } catch (e) {
      rxRequestStatus.value = Status.error;
      showErrorToast(toast, e.toString());
    }
  }

  reAssignSurgery() async {
    rxRequestStatus.value = Status.loading;
    var body = {
      "title": nameController.text,
      "description": descriptionController.text,
      "patient_id": userController.patientlId,
      "doctor_id": userController.doctorId,
      "approver_id": userController.approvalId,
      "status": "4",
      "date_time": date,
    };
    print(body);
    try {
      var response =
          await api.post(ApiNetwork.addReassignSurgeries, body, false);
      if (response["code"] == 200) { 
        rxRequestStatus.value = Status.success;
        showSuccessToast(toast, response['message']);
        Get.offAllNamed(AppRoutes.DASHBOARD, arguments: [1, 0]);
      } else if (response["success"] == false) {
        rxRequestStatus.value = Status.error;
        showErrorToast(toast, response['message']);
      }
    } catch (e) {
      rxRequestStatus.value = Status.error;
      showErrorToast(toast, e.toString());
    }
  }

  getPatient() async {
    rxRequestStatus.value = Status.loading;
    // Map<String, Object> payload =
    //   {
    //     "page": "1",
    //     "per_page": "20",
    //     "order_by": [
    //       {"column": "id", "order": "asc"}
    //     ],
    //     "filter_by": {}
    //   };

    try {
      var response = await api.post(
        ApiNetwork.patientList,
        null,
        false,
      );
      if (response['success'] = true) {
        rxRequestStatus.value = Status.success;
        patientList = [];
        var patientData = response["payload"]["data"];
        patientData.forEach((data) {
          patientList.add(PatientModel.fromJson(data));
        });
      } else {
        rxRequestStatus.value = Status.error;
        customFlutterToast(
            backgroundColor: Colors.red, msg: response["message"].toString());
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
    }
  }

  reassignSurgeries([patientId]) async {
    rxRequestStatus.value = Status.loading;

    var payload = {
      "page": "1",
      "per_page": "20",
      "filter_by": {
        "patient_id": patientId,
      }
      // "order_by": [
      //   {"column": "id", "order": "dsc"}
      // ],
    };
    if (kDebugMode) {
      print(payload);
    }
    try {
      var response = await api.post(
        ApiNetwork.reassignSurgeries,
        jsonEncode(payload),
        true,
      );
      if (response['success'] = true) {
        rxRequestStatus.value = Status.success;
        assignedSurgeryList = [];
        var assignedSurgeryListData = response["payload"]["data"];
        assignedSurgeryListData.forEach((data) {
          assignedSurgeryList.add(ReassignSurgeryModel.fromJson(data));
        });
      } else {
        rxRequestStatus.value = Status.error;
        customFlutterToast(
            backgroundColor: Colors.red, msg: response["message"].toString());
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
    }
  }

  patientAction(action, id) async {
    rxRequestStatus.value = Status.loading;
    Map<String, Object> payload = {"status": action, "description": "Sargam "};

    try {
      var response = await api.post(
        ApiNetwork.actionPatient + id,
        payload,
        false,
      );
      if (response['success'] = true) {
        rxRequestStatus.value = Status.success;
        Get.offAllNamed(AppRoutes.DASHBOARD, arguments: [1, 0]);
      } else {
        rxRequestStatus.value = Status.error;
        customFlutterToast(
            backgroundColor: Colors.red, msg: response["message"].toString());
      }
    } catch (e) {
      customFlutterToast(backgroundColor: Colors.red, msg: e.toString());
      rxRequestStatus.value = Status.error;
    }
  }

  @override
  void onClose() {
    patientList.clear();
    super.onClose();
  }
}
