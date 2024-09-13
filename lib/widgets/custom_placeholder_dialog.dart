import '../core/constants/app_export.dart';
import '../theme/text_style.dart';

// ignore: must_be_immutable
class PlaceholderDialog extends StatelessWidget {
  PlaceholderDialog({
    this.icon,
    this.title,
    this.message,
    this.colors,
    this.textbutton2,
    this.button,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final Color? colors;
  final IconData? icon;
  String? title = "Gotit!";
  String? button;
  bool? textbutton2 = false;
  final String? message;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      icon: Icon(
        icon,
        color: colors,
        size: 80.0,
      ),
      title: Text(
        title!,
        textAlign: TextAlign.center,
      ),
      titleTextStyle:
          AppTextStyles.bodyText.copyWith(fontWeight: FontWeight.bold),
      content: Text(
        message!,
        textAlign: TextAlign.center,
      ),
      contentTextStyle: AppTextStyles.smallText,
      actionsAlignment: MainAxisAlignment.center,
      actionsOverflowButtonSpacing: 8.0,
    );
  }
}
