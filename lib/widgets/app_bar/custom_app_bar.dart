import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../theme/color_constants.dart';
import '../../theme/text_style.dart';
import '../../utils/image_constant.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {Key? key,
      this.height,
      this.leadingWidth,
      this.leading,
      this.title,
      this.centerTitle,
      this.actions,
      this.scaffoldState,
      this.onPressed,
      this.filtterTab,
      this.isFiltter,
      this.isLeading,
      this.actions1,
      this.elevation = 2})
      : super(
          key: key,
        );

  final double? height;

  final double? leadingWidth;

  final double? elevation;

  final Widget? leading;

  final String? title;

  final bool? centerTitle;

  final Widget? actions;
  final Widget? actions1;

  final void Function()? filtterTab;

  final bool? isFiltter;
  final bool? isLeading;

  GlobalKey<ScaffoldState>? scaffoldState;

  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // systemOverlayStyle: const SystemUiOverlayStyle(
      //   statusBarIconBrightness: Brightness.light,
      // ),
      elevation: elevation,
      toolbarHeight: height ?? 60.h,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.whiteA700,
      // backgroundColor: AppColors.kprimary,
      // leadingWidth: leadingWidth ?? 30,
      leading: isLeading == true
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: leading ??
                  IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: onPressed),
            )
          : null,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Text(
          title ?? "",
          style: AppTextStyles.text18Black800
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      //titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: [
        actions == null ? Container() : actions!,
        isFiltter == true
            ? IconButton(
                onPressed: filtterTab ?? () {},
                icon: SvgPicture.asset(
                  ImageConstant.filter,
                  // ignore: deprecated_member_use
                  color: AppColors.kprimary,
                ),
              )
            : actions1 == null
                ? Container()
                : actions1!,
      ],
    );
  }

  @override
  Size get preferredSize => Size(
        double.infinity,
        height ?? 60.h,
      );
}
