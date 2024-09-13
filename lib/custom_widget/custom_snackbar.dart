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
        backgroundColor: appTheme.whiteA700,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  "Delete !",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: appTheme.black900,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Icon(
                  Icons.info,
                  size: 80,
                  color: Colors.amber,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Are you sure! You want to delete this?",
                style: TextStyle(fontSize: 20, color: appTheme.blueGray900),
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              backgroundColor: appTheme.blueGray900,
            ),
            onPressed: noTap,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'No',
                style: TextStyle(color: appTheme.whiteA700, fontSize: 15),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              backgroundColor: Colors.red,
            ),
            onPressed: deleteTap,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Yes, delete it',
                style: TextStyle(color: appTheme.whiteA700, fontSize: 15),
              ),
            ),
          ),
        ],
      );
    },
  );
}
