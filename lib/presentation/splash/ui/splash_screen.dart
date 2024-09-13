import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../theme/color_constants.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // mediaQueryData = MediaQuery.of(context);
 Get.put(SplashController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.kprimary,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                color: AppColors.whiteA700,
                height: 180.h,
                width: 180.h,
              ),
              SizedBox(height: 20.h),
              Center(
                  child: SizedBox(
                      height: 25.h,
                      width: 25.w,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.whiteA700,
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
