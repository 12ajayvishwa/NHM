import 'package:pvi_nhm/core/constants/app_export.dart';
import 'package:pvi_nhm/data/model/patient_model.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../controllers/auth_controller.dart';
import '../../../controllers/patient_controller.dart';
import '../../../data/apiClient/http_response.dart';



class PatientSearchController extends GetxController {
  TextEditingController searchController = TextEditingController();
  PatientController patientController = Get.put(PatientController());
  AuthController authController = Get.put(AuthController());
  final rxRequestStatus = Status.success.obs;

  List selectedCategoryList = [].obs;
  List allSelect = [].obs;

  var searchQuery = ''.obs;
  var isAllSelect = true.obs;

  List<PatientModel> get filteredPatients {
    rxRequestStatus.value = Status.loading;

    List<PatientModel> filteredList = patientController.patientList;

    if (searchQuery.isNotEmpty) {
      filteredList = filteredList.where((patient) {
        final nameMatch = patient.patientName
                ?.toLowerCase()
                .contains(searchQuery.toLowerCase()) ??
            false;

        return nameMatch;
      }).toList();
    }

    rxRequestStatus.value = Status.success;
    return filteredList;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    update();
  }

  

 

  String getTimeAgo(DateTime date) {
    return timeago.format(date);
  }

  clearData() {
    searchController.text = "";
    searchQuery.value = "";
    update();
  }
}
