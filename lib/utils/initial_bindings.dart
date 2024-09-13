import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';


import '../core/network/network_info.dart';
import 'pref_utils.dart';


class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    
    Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(connectivity));
  }
}
