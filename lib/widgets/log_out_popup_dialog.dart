import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pvi_nhm/theme/color_constants.dart';
import '../core/constants/app_export.dart';
import '../theme/text_style.dart';

class LogOutPopUpDialog extends StatelessWidget {
  final void Function()? onPressed;
  final String? title;
  final String? msg;
  final Color? color;

  const LogOutPopUpDialog(
      {super.key, this.onPressed, this.title, this.msg, this.color});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.whiteA700,
        ),
        padding: EdgeInsets.all(30.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? "Log Out",
              textAlign: TextAlign.center,
              style: AppTextStyles.headline.copyWith(
                fontSize: 26.sp,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              msg ?? "Are you sure you want to signout?",
              style: AppTextStyles.text14White400
                  .copyWith(color:color?? AppColors.blackLight, fontSize: 16.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: onPressed,
                    child: Text(
                      "ok",
                      style: AppTextStyles.text18White600.copyWith(
                          color: AppColors.kprimary,
                          fontWeight: FontWeight.bold),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: AppTextStyles.text18White600.copyWith(
                          color: AppColors.kprimary,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
