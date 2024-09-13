

import '../core/constants/app_export.dart';
import '../theme/theme_helper.dart';


customFlutterToast(
    {Color backgroundColor = Colors.green,
    String? msg,
    String? status,
    Color textColor = Colors.white}) {
  Get.snackbar(
      isDismissible: true,
      borderRadius: 10,
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: backgroundColor,
      status ?? "Message",
      msg!,
      colorText: textColor);
}

void showAlertDialog(context, VoidCallback noTap, VoidCallback deleteTap,
    {title, msg}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          actionsOverflowButtonSpacing: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          surfaceTintColor: Colors.white,
          title: Text(title ?? "Delete..!"),
          content: Text(
            msg ?? 'Are you sure you want to delete this?',
            // style: kCaption.copyWith(color: Colors.grey),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    backgroundColor: appTheme.gray),
                onPressed: noTap,
                child: const Text(
                  'NO',
                  // style: kCaption.copyWith(color: Colors.white),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    backgroundColor: appTheme.red600D8),
                onPressed: deleteTap,
                child: const Text(
                  'YES',
                  // style: kCaption.copyWith(
                  //   color: Colors.white,
                  // ),
                )),
          ],
        );
      });
}
