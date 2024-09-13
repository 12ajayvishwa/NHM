import 'package:pvi_nhm/core/constants/app_export.dart';
import 'package:pvi_nhm/data/model/patient_model.dart';
import 'package:pvi_nhm/data/model/user_list_model.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../controllers/auth_controller.dart';
import '../../../controllers/patient_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../data/apiClient/http_response.dart';



class UserSearchController extends GetxController {
  TextEditingController searchController = TextEditingController();
  UserController userController = Get.put(UserController());
  AuthController authController = Get.put(AuthController());
  final rxRequestStatus = Status.success.obs;

  List selectedCategoryList = [].obs;
  List allSelect = [].obs;

  var searchQuery = ''.obs;
  var isAllSelect = true.obs;

  List<UserListModel> get filteredPatients {
    rxRequestStatus.value = Status.loading;

    List<UserListModel> filteredList = userController.userList;

    if (searchQuery.isNotEmpty) {
      filteredList = filteredList.where((user) {
        final nameMatch = user.name
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
