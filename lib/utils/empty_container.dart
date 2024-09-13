import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/app_export.dart';
import '../theme/color_constants.dart';
import '../theme/text_style.dart';

// ignore: must_be_immutable
class EmptyContainer extends StatelessWidget {
  void Function()? onTap;
  bool? isOnTap;
  String? msg;
  String? imageUrl;
  EmptyContainer({super.key, this.onTap, this.msg, this.isOnTap,this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
           imageUrl?? "assets/svg/empty2.svg",
            height: 150.h,
            width: 150.w,
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            width: 300.w,
            child: Text(
              msg ?? "Something went wrong",
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyText,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          isOnTap != true
              ? Container()
              : InkWell(
                  onTap: onTap,
                  child: Container(
                    height: 44.h,
                    width: 160.w,
                    decoration: BoxDecoration(
                        color: AppColors.kprimary,
                        borderRadius: BorderRadius.circular(50.r)),
                    child: Center(
                      child: Text(
                        "Retry",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
