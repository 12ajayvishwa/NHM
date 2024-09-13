
import 'package:flutter_svg/svg.dart';
import 'package:pvi_nhm/utils/size_utils.dart';
import '../../core/constants/app_export.dart';
import '../../theme/theme_helper.dart';

Stack appBarActions(void Function()? onPressed,
    {icon = "assets/svg/edit-svgrepo-com.svg", double right = 0}) {
  return Stack(children: [
    Padding(
      padding: EdgeInsets.only(left: 8.0, right: right),
      child: Container(
        height: 40.v,
        width: 40.h,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: appTheme.orange.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 3)
            ]),
        child: IconButton(
            onPressed: onPressed,
            icon: SvgPicture.asset(
              icon,
              width: 44.h, 
              height:  44.v,
              color: appTheme.orange
            )),
      ),
    ),
  ]);
}