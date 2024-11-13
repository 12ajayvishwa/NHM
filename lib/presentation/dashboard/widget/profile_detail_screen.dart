import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pvi_nhm/data/model/user_list_model.dart';
import 'package:pvi_nhm/theme/text_style.dart';
import 'package:pvi_nhm/widgets/app_bar_container.dart';
import '../../../core/constants/app_export.dart';
import '../../../theme/color_constants.dart';


class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserListModel data = Get.arguments;

    // print(data.accountType);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: appBarContainer(
                  size,
                  title: "Profile",
                  isLeading: true,
                ),
              ),
              Positioned(
                top: size.height * 0.12,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(120.r),
                    child: data.avatar == null
                        ? Image.asset(
                            data.gender != 'female'
                                ? "assets/images/doctor_dummy.jpg"
                                : "assets/images/2151107332.jpg",
                            height: 120.h,
                            width: 120.w,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            data.avatar!,
                            height: 120.h,
                            width: 120.w,
                            fit: BoxFit.cover,
                          )),
              ),
              // Positioned(
              //   top: 100.h,
              //   left: 10.w,
              //   right: 10.w,
              //   child: DoctorCardWidget(
              //     gender: data.gender ?? "male",
              //     imageUrl: data.avatar == null
              //         ? null
              //         : ApiNetwork.imageUrl + data.avatar,
              //     name: "${data.name!.toString().capitalize ?? "N/A"}",
              // designation: data.role == "2"
              //     ? "Approval"
              //     : data.role == "3"
              //         ? "Doctor"
              //         : "Admin",
              //     phoneNumber: data.phone,
              //   ),
              // ),
              Positioned(
                bottom: -40.h,
                right: -15.w,
                child: SvgPicture.asset("assets/svg/Rectangle 5904.svg"),
              ),
              Positioned(
                  top: 260.h,
                  left: 10.w,
                  right: 10.w,
                  bottom: 10.h,
                  child: detailsForm(data)),
            ],
          ),
        ),
      ),
    );
  }

  detailsForm(UserListModel data) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
            )
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
          buildFieldWidget("Name", data.name ?? ""),
          buildFieldWidget("Gender", data.gender ?? ""),
          buildFieldWidget("Phone number", "+91 ${data.phone ?? ""}"),
          buildFieldWidget("E-mail", data.email ?? ""),
          buildFieldWidget("Registration No.", data.registrationNo ?? "N/A"),
          buildFieldWidget(
            "Role",
            data.role == "2"
                ? "Approval"
                : data.role == "3"
                    ? "Doctor"
                    : "Admin",
          ),
           buildFieldWidget("Address", data.address ?? "N/A"),
          
          
        ]),
      ),
    );
  }

  buildFieldWidget(helper, value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            helper,
            style: AppTextStyles.text14WhiteBold
                .copyWith(color: AppColors.gray, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0.w),
            child: Text(
              value.toString().capitalizeFirst!,
              style: AppTextStyles.text16Black600,
            ),
          ),
          Divider(
            thickness: 1,
            color: AppColors.black900,
          )
        ],
      ),
    );
  }
}
