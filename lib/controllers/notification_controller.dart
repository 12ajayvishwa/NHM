
import 'dart:convert';
import '../../data/apiClient/api_client.dart';
import '../../data/model/notification_model.dart';
import '../core/constants/api_network.dart';
import '../core/constants/app_export.dart';
import '../core/constants/session_manager.dart';
import '../data/apiClient/http_response.dart';
import '../utils/custom_toast.dart';

var unreadNotification;

class NotificationController extends GetxController {
  final rxRequestStatus = Status.success.obs;
  NetworkHttpServices api = NetworkHttpServices();
  List<NotificationsModel> notifications = <NotificationsModel>[].obs;
  var pageKey = 1.obs;
  var perPage = 10;

  getNotification({pageKey, pageSize, searchTerm}) async {
    var payload = {
      "page": pageKey,
      "per_page": pageSize,
      "filter_by": {
        "user_id": SessionManager.getUserId() ?? "",
      }
      // "order_by": [
      //   {"column": "id", "order": "dsc"}
      // ],
    };
    print(payload);
    rxRequestStatus.value = Status.loading;
    try {
      var data =
          await api.post(ApiNetwork.notification, jsonEncode(payload), true);
      if (data['success'] = true) {
        var notificationData = data["payload"]["data"];

        notificationData.forEach((data) {
          notifications.add(NotificationsModel.fromJson(data));
        });
        unreadNotification = data["payload"]["meta"]["unread"];
        rxRequestStatus.value = Status.success;
        return notificationData;
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

  readNotification({id}) async {
    rxRequestStatus.value = Status.loading;
    try {
      var data =
          await api.put(ApiNetwork.readNotification + "$id", null, false);
      if (data['success'] = true) {
        print("read");
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
