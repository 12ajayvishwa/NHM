import '../controller/login_verification_controller.dart';
import 'package:get/get.dart';

/// A binding class for the Iphone14Pro101Screen.
///
/// This class ensures that the Iphone14Pro101Controller is created when the
/// Iphone14Pro101Screen is first loaded.
class LoginVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginVerificationController());
  }
}
