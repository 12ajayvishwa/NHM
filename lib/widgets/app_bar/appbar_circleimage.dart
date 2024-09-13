import 'package:pvi_nhm/utils/size_utils.dart';

import '../../core/constants/app_export.dart';
import '../custom_image_view.dart';




// ignore: must_be_immutable
class AppbarCircleimage extends StatelessWidget {
  AppbarCircleimage({
    Key? key,
    this.imagePath,
    this.svgPath,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String? imagePath;

  String? svgPath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // borderRadius: BorderRadiusStyle.circleBorder30,
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomImageView(
          svgPath: svgPath,
          imagePath: imagePath,
          height: 60.adaptSize,
          width: 60.adaptSize,
          fit: BoxFit.contain,
          radius: BorderRadius.circular(
            30.h,
          ),
        ),
      ),
    );
  }
}
