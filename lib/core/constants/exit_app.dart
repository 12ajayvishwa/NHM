
import '../../widgets/custom_alert_dialog.dart';
import 'app_export.dart';

Future<bool> backButtonPressed(BuildContext context) async {
  bool exitApp = await showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
            title: "Exit App",
            message: "Are you sure you want to exit the app?",
            cancelTitle: "No",
            okTitle: "Yes",
            icon: Icons.error_outline,
            // colors: AppColors.red600D8,
            onPressedCancel: () {
              Navigator.of(context).pop(false);
            },
            onPressedOk: () {
              Navigator.of(context).pop(true);
            });
      },
      barrierDismissible: false);

  return exitApp;
}
