import 'package:fluttertoast/fluttertoast.dart';
import 'package:pvi_nhm/utils/string_capitalization.dart';
import '../core/constants/app_export.dart';
import '../theme/color_constants.dart';
import '../theme/text_style.dart';

calenderTheme(child, context) {
  return Theme(
      data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
              primary: AppColors.kprimary,
              onPrimary: Colors.white,
              onSurface: Colors.grey),
          dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14))),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                  textStyle: AppTextStyles.bodyText))),
      child: child!);
}

dropDownError({msg}) {
  Fluttertoast.showToast(
      msg: msg.toString().toCapitalized(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
  return null;
}
