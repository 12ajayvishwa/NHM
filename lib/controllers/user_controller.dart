import 'package:pvi_nhm/core/constants/app_export.dart';
import 'package:pvi_nhm/data/model/user_list_model.dart';
import '../core/constants/api_network.dart';
import '../core/routes/app_routes.dart';
import '../data/apiClient/api_client.dart';
import '../data/apiClient/http_response.dart';
import 'auth_controller.dart';
import '../utils/custom_toast.dart';
import 'setting_controller.dart';

class UserController extends GetxController {
  final rxRequestStatus = Status.success.obs;
  NetworkHttpServices api = NetworkHttpServices();
  SettingController settingController = Get.put(SettingController());
  AuthController authController = Get.put(AuthController());

  //Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController registrationNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<UserListModel> userList = [];

  List<UserListModel> approvalList = [];
  List<UserListModel> doctorList = [];

  String doctorId = "";
  String approvalId = "";
  String patientlId = "";

  addUser(verify, gender) async {
    print(gender);
    print(passwordController.text);
    rxRequestStatus.value = Status.loading;
    var body = {
      "name": nameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "registrationNo": registrationNoController.text,
      "gender": gender,
      "user_type_id": authController.userTypeId.toString(),
      "password": passwordController.text,  
      "address": addressController.text,
      "active": "true", 
      "role": authController.userTypeId.toString()
    };
    print(body);
    try {
      var response = await api.post(ApiNetwork.userCreate, body, false);
      if (response["code"] == 200) {
        rxRequestStatus.value = Status.success;
        showSuccessToast(toast, response['message']);
        Get.offAllNamed(AppRoutes.DASHBOARD, arguments: [2, 0]);
      } else if (response["success"] == false) {
        rxRequestStatus.value = Status.error;
        showErrorToast(toast, response['message']);
      }
    } catch (e) {
      rxRequestStatus.value = Status.error;
      showErrorToast(toast, e.toString());
    }
  }

  Future<void> getUserList() async {
    // var payload = {
    //   "user_type_id": "2",
    // };

    rxRequestStatus.value = Status.loading;
    var response = await api.post(ApiNetwork.users, null, false);
    if (response['success'] == true) {
      var usersData = response["payload"]["data"];

      usersData.forEach((data) {
        UserListModel user = UserListModel.fromJson(data);
        if (user.userTypeId == "3") {
          doctorList.add(user);
        }

        if (user.userTypeId == "2") {
          approvalList.add(user);
        }

        // Add to the general user list
        userList.add(user);
      });
      //print(response.body);
      rxRequestStatus.value = Status.success;
    }
  }

  clearData() {
    userList.clear();
    doctorList.clear();
    approvalList.clear();
  }

  @override
  void onClose() {
    userList.clear();
    super.onClose();
  }
}
