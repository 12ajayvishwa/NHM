import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pvi_nhm/core/constants/session_manager.dart';
import 'core/constants/app_export.dart';
import 'core/routes/app_routes.dart';
import 'firebase_options.dart';
import 'notification/notification_service.dart';
import 'presentation/auth/binding/auth_binding.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManager.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(450, 936),
      minTextAdapt: true,    
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PVI NHM',
        locale: Get.deviceLocale,
        //home: const LoginScreen(),
        navigatorKey: navigatorKey,
        initialBinding: AuthBinding(),
        initialRoute: AppRoutes.SPLASHSCREEN,
        getPages: AppRoutes.pages,
        // routes: {
        //   NotificationScreen.route: (context) => const NotificationScreen(),
        // },
      ),
    );
  }
}
