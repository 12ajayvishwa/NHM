import 'package:pvi_nhm/core/constants/app_export.dart';

import '../../../core/constants/api_network.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/apiClient/http_response.dart';
import '../../../utils/custom_toast.dart';

class HomeController extends GetxController {
  RxBool isExpanded = false.obs;
  NetworkHttpServices api = NetworkHttpServices();
  final rxRequestStatus = Status.success.obs;
  String totalDoc = "0";
  String totalPatient = "0";
  String supervisor = "0";
  String completes = "0";
  String pending = "0";
  String done = "0";
  var categoryList = [];

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      isExpanded.value = true;
    } else if (details.delta.dy > 0) {
      isExpanded.value = false;
    }
  }

  getDashboard() async {
    rxRequestStatus.value = Status.loading;
    try {
      var data = await api.post(ApiNetwork.getDashboard, null, false);
      if (data["success"] == true) {
        totalDoc = data["payload"]["TotalDoctors"].toString();
        totalPatient = data["payload"]["TotalPatients"].toString();
        supervisor = data["payload"]["TotalSupervisors"].toString();
        completes = data["payload"]["TotalCompleted"].toString();
        pending = data["payload"]["TotalPending"].toString();
        done = data["payload"]["TotalDone"].toString();
        rxRequestStatus.value = Status.success;
        update();
        // showErrorToast(toast, data['message']);
      } else {
        rxRequestStatus.value = Status.error;

        showErrorToast(toast, data['message']);
      }
    } catch (e) {
      rxRequestStatus.value = Status.error;
      showErrorToast(toast, e.toString());
    }
    update();
  }
}
