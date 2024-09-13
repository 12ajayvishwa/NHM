// ignore: duplicate_ignore
// ignore: must_be_immutable
// ignore_for_file: must_be_immutable

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_export.dart';
import '../theme/color_constants.dart';
import '../theme/text_style.dart';

class CustomAlertDialog extends StatelessWidget {
  CustomAlertDialog({
    this.icon,
    this.title,
    this.message,
    this.colors,
    this.onPressedCancel,
    this.onPressedOk,
    this.cancelTitle,
    this.isCancel,
    this.okTitle,
    Key? key,
  }) : super(key: key);

  final Color? colors;
  final IconData? icon;
  String? title = "Gotit!";
  final String? message;
  bool? isCancel = false;
  final String? cancelTitle;
  final String? okTitle;
  final VoidCallback? onPressedCancel;
  final VoidCallback? onPressedOk;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: AppColors.whiteA700,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      icon: Icon(
        icon ?? Icons.wifi_off,
        color: colors,
        size: 80.0,
      ),
      title: Text(
        title!,
        textAlign: TextAlign.center,
      ),
      titleTextStyle:
          AppTextStyles.text18Black600.copyWith(fontWeight: FontWeight.bold),
      content: Text(
        message!,
        textAlign: TextAlign.center,
      ),
      contentTextStyle: AppTextStyles.smallText,
      actionsAlignment: MainAxisAlignment.center,
      actionsOverflowButtonSpacing: 8.0,
      actions: [
        ElevatedButton(
            onPressed: onPressedOk,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.black121212,
            ),
            child: Text(
              okTitle ?? "Ok",
              style:
                  AppTextStyles.smallText.copyWith(color: AppColors.whiteA700),
            )),
        if (cancelTitle != null) SizedBox(width: 30.w),
        if (cancelTitle != null)
          ElevatedButton(
            onPressed: onPressedCancel,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.black121212,
            ),
            child: Text(
              cancelTitle ?? "Cancel",
              style:
                  AppTextStyles.smallText.copyWith(color: AppColors.whiteA700),
            ),
          ),
      ],
    );
  }
}
