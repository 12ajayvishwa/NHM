import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../core/constants/app_export.dart';
import '../theme/color_constants.dart';
import '../theme/text_style.dart';

// ignore: must_be_immutable
class RequestCardWidget extends StatelessWidget {
  final String? startTime;
  final String? endTime;
  final String? titile;
  final String? msg;
  final String? date;
  final String? dateDay;
  final String? timeAgo;
  void Function()? onTap;

  RequestCardWidget(
      {super.key,
      this.startTime,
      this.endTime,
      this.titile,
      this.msg,
      this.date,
      this.timeAgo,
      this.dateDay,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.h, right: 20.w, left: 20.w, top: 10.h),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.ksecondaryColor,
        borderRadius: BorderRadius.circular(
          15.r,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                  decoration: BoxDecoration(
                      color: AppColors.whiteA700,
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 50.w,
                          child: Text(
                            date.toString() ?? "",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.text18Black800
                                .copyWith(fontSize: 16.sp),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          width: 50.w,
                          child: Text(
                            dateDay.toString() ?? "",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.text18Black800
                                .copyWith(fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      startTime == null || endTime == null
                          ? Container()
                          : Text(
                              "$startTime - $endTime",
                              style: AppTextStyles.text10White400,
                            ),
                      SizedBox(
                        width: 180.w,
                        child: Text(titile.toString().capitalizeFirst ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.text18White600),
                      ),
                      SizedBox(
                        height: 5.w,
                      ),
                      SizedBox(
                        width: 230.w,
                        child: Text(
                          msg ?? "",
                          style: AppTextStyles.text14White400,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0.w,
              top: 0.h,
              child: Column(
                children: [
                  InkWell(
                    onTap: onTap,
                    child: SvgPicture.asset(
                      "assets/svg/menu_second.svg",
                      // ignore: deprecated_member_use
                      color: AppColors.whiteA700,
                      height: 25.h,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    width: 60.w,
                    child: Text(
                      timeAgo ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.text12WhiteRegular,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
