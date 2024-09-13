import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pvi_nhm/theme/color_constants.dart';
import '../core/constants/app_export.dart';
import '../theme/gradient.dart';
import '../theme/text_style.dart';

appBarContainer(
  Size? size, {
  String? title,
  bool? isTabBar,
  bool? isLeading,
  Widget? leading,
  Widget? tabBar,
}) {
  return Container(
      height: 150.h,
      decoration: BoxDecoration(
          gradient: AppGradient.kTopContainerColor(),
          //color: Colors.amber,
          border: isTabBar == true
              ? Border(bottom: BorderSide(color: AppColors.gray))
              : null),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          isLeading == true
              ? Positioned(
                  left: 15.w,
                  top: 35.h,
                  child: leading ??
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.black900,
                          )))
              : Container(),
          Positioned(
            top: 50.h,
            child: SizedBox(
              width: 280.w,
              child: Text(
                title ?? "",
                textAlign: TextAlign.center,
                style: AppTextStyles.text16Black600
                    .copyWith(fontWeight: FontWeight.w600,fontSize: 20.sp),
              ),
            ),
          ),
          isTabBar == true ? tabBar ?? Container() : Container(),
        ],
      ));
}
