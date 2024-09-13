import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../core/constants/app_export.dart';
import '../theme/text_style.dart';
import 'custom_elevated_button.dart';

class SuccessPopUpDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function()? onTap;
  const SuccessPopUpDialog(
      {super.key, required this.title, required this.message, this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(69.r)),
      child: Container(
        height: size.height / 2,
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/svg/success_image.svg",
              width: 200.w,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(title,
                textAlign: TextAlign.center,
                style: AppTextStyles.text16BlackBold.copyWith(fontSize: 24.sp)),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Text(message,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.text14BlackMedium),
            ),
            onTap == null
                ? Container()
                :  SizedBox(
              height: 40.h,
            ),
            onTap == null
                ? Container()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100.w),
                    child: CustomElevatedButton(text: "OK", onTap: onTap),
                  ),
          ],
        ),
      ),
    );
  }
}
