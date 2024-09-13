import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../data/apiClient/api_client.dart';
import '../../data/apiClient/http_response.dart';
import '../../widgets/custom_placeholder_dialog.dart';
import 'app_export.dart';

String? ipAddress; // IP address of the device

class ConnectivityController extends GetxController {
  NetworkHttpServices api = NetworkHttpServices();
  final rxRequestStatus = Status.success.obs;
  final Connectivity _connectivity = Connectivity();

  final RxBool isConnected = true.obs;
  bool _isDialogShowing = false;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    _startConnectivityMonitoring();
    getIPAddress();
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  void _startConnectivityMonitoring() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) {
        _updateConnectionStatus(result);
      },
    );
    _checkInitialConnectivity();
  }

  Future<void> _checkInitialConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    bool isConnectedNow = result != ConnectivityResult.none;

    isConnected.value = isConnectedNow;

    if (!isConnectedNow && !_isDialogShowing) {
      _showNoInternetDialog();
    } else if (isConnectedNow && _isDialogShowing) {
      Get.back(); // Close the dialog
      _isDialogShowing = false;
    }
  }

  void _showNoInternetDialog() {
    _isDialogShowing = true;
    Get.dialog(
      PlaceholderDialog(
        title: "No Internet",
        message: "Please check your internet connection",
        icon: Icons.wifi_off,
      ),
      barrierDismissible: false,
    );
  }

  //For ip Address
  getIPAddress() async {
    final url = 'https://api.ipify.org/?format=json';
    HttpClientRequest request = await HttpClient().getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    if (response.statusCode == 200) {
      String data = await response.transform(utf8.decoder).join();

      ipAddress = json.decode(data)['ip'];

      return jsonDecode(data)['ip'];
    } else {
      return 'Unknown';
    }
  }
}
