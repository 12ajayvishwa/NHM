import 'package:get/get.dart';
import '../../../core/constants/session_manager.dart';
import '../../../core/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3));
    Get.offAllNamed(
      SessionManager.getToken() == null
          ? AppRoutes.ONBOARDSCREEN
          : AppRoutes.DASHBOARD,
    );
  }
}
