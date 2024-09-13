import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pvi_nhm/widgets/custom_elevated_button.dart';

import '../core/constants/app_export.dart';
import '../core/constants/session_manager.dart';
import '../theme/color_constants.dart';
import '../theme/text_style.dart';

class DoctorCardWidget extends StatelessWidget {
  final String? gender;
  final String? imageUrl;
  final String? name;
  final String? designation;
  final String? approvalDoc;
  final String? secondApDoc;
  final String? phoneNumber;
  final bool? isUserList;
  final String? age;
  final String? title;
  final DateTime? date;
  final int? status;
  final void Function()? onTap;
  const DoctorCardWidget(
      {super.key,
      this.name,
      this.isUserList = false,
      this.status,
      this.designation,
      this.approvalDoc,
      this.secondApDoc,
      this.phoneNumber,
      this.imageUrl,
      this.gender,
      this.onTap,
      this.age,
      this.title,
      this.date});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                  color: AppColors.gray.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 6)
            ]),
        child: Stack(
          children: [
            isUserList == false
                ? Container()
                : Positioned(
                    right: 0.w,
                    // top: 30.h,
                    // bottom: 30.h,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.w, horizontal: 10.w),
                        decoration: BoxDecoration(
                            color: designation == "Admin"
                                ? AppColors.red600D8
                                : designation == "Approval"
                                    ? Colors.orangeAccent
                                    : Colors.blue,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.r),
                              // bottomRight: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r),
                            )),
                        child: Text(
                          designation!,
                          style: AppTextStyles.text14White400,
                        ))),
            if (status != null)
              Positioned(
                top: 10.h,
                right: 10.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    isUserList == false
                        ? Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                                color: status == 1
                                    ? Colors.blue
                                    : status == 2
                                        ? AppColors.green600
                                        : status == 3
                                            ? AppColors.green600
                                            : status == 4
                                                ? Colors.orangeAccent
                                                : Colors.red,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.r),
                                    bottomLeft: Radius.circular(10.r))),
                            child: Text(
                                status == 1
                                    ? "Completed"
                                    : status == 2
                                        ? "Approved"
                                        : status == 3
                                            ? "Done"
                                            : status == 4
                                                ? "Pending"
                                                : "Cancel",
                                style: AppTextStyles.text14White400),
                          )
                        : Container(),
                    SessionManager.getUserTypeId() == "2"
                        ? SizedBox(
                            height: 5.h,
                          )
                        : Container(),
                    SessionManager.getUserTypeId() == "2"
                        ? Text(
                            status == 2
                                ? "Click and approve"
                                : "Click to see details",
                            style: AppTextStyles.text10DarkGreen400,
                          )
                        : Container(),
                  ],
                ),
              ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200.w,
                    child: Text(
                      name ?? "",
                      // overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: AppTextStyles.text18Black600
                          .copyWith(color: const Color(0XFF333333)),
                    ),
                  ),
                  isUserList == false
                      ? SizedBox(
                          width: 200.w,
                          child: Text(
                            designation ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.text14BlackMedium
                                .copyWith(color: AppColors.green600),
                          ),
                        )
                      : Container(),
                  isUserList == false ? Divider() : Container(),
                  age == null || date == null
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 120.w,
                              child: Text(
                                "title :  $title" ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.text14BlackMedium
                                    .copyWith(color: AppColors.gray),
                              ),
                            ),
                            SizedBox(
                              width: 80.w,
                              child: Text(
                                "age : $age" ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.text14BlackMedium
                                    .copyWith(color: AppColors.gray),
                              ),
                            ),
                            SizedBox(
                              width: 150.w,
                              child: Text(
                                "Date : ${DateFormat('yyyy-MM-dd').format(date! as DateTime)}" ??
                                    "",
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.text14BlackMedium
                                    .copyWith(color: AppColors.gray),
                              ),
                            ),
                          ],
                        ),
                  age == null || date == null
                      ? Container()
                      : isUserList == false
                          ? Divider()
                          : Container(),
                  approvalDoc != null
                      ? SizedBox(
                          width: 200.w,
                          child: Text(
                            approvalDoc ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.text14BlackMedium
                                .copyWith(color: AppColors.gray),
                          ),
                        )
                      : Container(),
                  secondApDoc == null
                      ? Container()
                      : SizedBox(
                          width: 200.w,
                          child: Text(
                            secondApDoc ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.text14BlackMedium
                                .copyWith(color: AppColors.gray),
                          ),
                        ),

                  phoneNumber == null
                      ? Container()
                      : SizedBox(
                          height: 6.h,
                        ),
                  phoneNumber == null
                      ? Container()
                      : SizedBox(
                          width: 200.w,
                          child: Text(
                            phoneNumber ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.text14BlackMedium
                                .copyWith(color: AppColors.gray),
                          ),
                        ),

                  // Row(
                  //   children: [
                  //     SvgPicture.asset(
                  //       isVerified == "true"
                  //           ? "assets/svg/verified.svg"
                  //           : "assets/icons/not_verified.svg",
                  //     ),
                  //     SizedBox(
                  //       width: 10.w,
                  //     ),
                  //     Text(
                  //       isVerified == "true" ? "Verified" : "Not Verified",
                  //       style: AppTextStyles.text12WhiteRegular
                  //           .copyWith(color: AppColors.gray),
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
            // isSeen != null
            //     ? Positioned(
            //         bottom: 15.h,
            //         right: 20.w,
            //         child: SvgPicture.asset(
            //           "assets/icons/seen_icon.svg",
            //           color: isSeen == true ? Colors.blue : AppColors.gray,
            //         ))
            //     : Container()
          ],
        ),
      ),
    );
  }

  Row rowBuild(value) {
    return Row(
      children: [
        Container(
          height: 10.h,
          width: 10.w,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: AppColors.green600),
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          value,
          style: AppTextStyles.text10White400.copyWith(color: AppColors.gray),
        )
      ],
    );
  }
}
