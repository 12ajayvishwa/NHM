import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants/app_export.dart';
import '../theme/color_constants.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: 30.h,
      width: 30.w,
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.kprimary,
        ),
      ))
    );
  }
}
