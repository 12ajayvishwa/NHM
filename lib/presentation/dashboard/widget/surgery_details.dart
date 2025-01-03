import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pvi_nhm/controllers/patient_controller.dart';
import 'package:pvi_nhm/data/model/reassign_surgery_model.dart';
import 'package:pvi_nhm/theme/text_style.dart';
import 'package:pvi_nhm/widgets/app_bar_container.dart';
import 'package:pvi_nhm/widgets/custom_circuler_loader.dart';
import '../../../core/constants/app_export.dart';
import '../../../core/constants/session_manager.dart';
import '../../../data/apiClient/http_response.dart';
import '../../../theme/color_constants.dart';
import '../../../widgets/custom_elevated_button.dart';

class SurgeryDetailScreen extends StatefulWidget {
  const SurgeryDetailScreen({super.key});

  @override
  State<SurgeryDetailScreen> createState() => _SurgeryDetailScreenState();
}

class _SurgeryDetailScreenState extends State<SurgeryDetailScreen> {
  PatientController patientController = Get.put(PatientController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ReassignSurgeryModel data = Get.arguments;

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
                  title: "Assigned Surgery Detail",
                  isLeading: true,
                ),
              ),
              
             
              Positioned(
                bottom: -40.h,
                right: -15.w,
                child: SvgPicture.asset("assets/svg/Rectangle 5904.svg"),
              ),
              Positioned(
                  top: 120.h,
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

  detailsForm(ReassignSurgeryModel data) {
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
        child: ListView(padding: EdgeInsets.all(0), children: [
          buildFieldWidget("Name", data.patient!.patientName ?? ""),
          buildFieldWidget("Gender", data.patient!.gender ?? ""),
          buildFieldWidget("Phone number", "+91 ${data.patient!.phone ?? ""}"),
          buildFieldWidget("Registration No.", data.patient!.registrationNo ?? "N/A"),
          buildFieldWidget("Surgery", data.patient!.electiveSurgery ?? "N/A"),
          buildFieldWidget("Address", data.patient!.address ?? "N/A"),
          SessionManager.getUserTypeId() == "2"
              ? buildFieldWidget(
                  "Assigned Doctor",
                  "Dr. ${data.doctor!.name.toString().capitalizeFirst}" ??
                      "N/A")
              : SessionManager.getUserTypeId() == "3"
                  ? buildFieldWidget(
                      "Assigned Doctor",
                      "Superviser. ${data.approver!.name.toString().capitalizeFirst}" ??
                          "N/A")
                  : Container(),
          SessionManager.getUserTypeId() == "1"
              ? buildFieldWidget(
                  "Assigned Doctor",
                  "Dr. ${data.doctor!.name.toString().capitalizeFirst}" ??
                      "N/A")
              : Container(),
          SessionManager.getUserTypeId() == "1"
              ? buildFieldWidget(
                  "Assigned Doctor",
                  "Sv. ${data.approver!.name.toString().capitalizeFirst}" ??
                      "N/A")
              : Container(),
          buildFieldWidget(
              "Status",
              data.status == 1
                  ? "Completed"
                  : data.status == 2
                      ? "Approved"
                      : data.status == 3
                          ? "Done"
                          : data.status == 4
                              ? "Pending"
                              : "Cancel" ?? "N/A",
              data.status == 1
                  ? Colors.blue
                  : data.status == 2
                      ? AppColors.green600
                      : data.status == 3
                          ? AppColors.green600
                          : data.status == 4
                              ? Colors.yellow
                              : Colors.red),
          data.status == 4
              ? SessionManager.getUserTypeId() == "2"
                  ? Obx(() {
                      return SizedBox(
                          height: 60.h,
                          width: 90.w,
                          child: patientController.rxRequestStatus.value ==
                                  Status.loading
                              ? const CustomLoading()
                              : CustomElevatedButton(
                                  text: "Approve",
                                  onTap: () {
                                    patientController.patientAction(
                                        "2", data.id.toString());
                                  },
                                ));
                    })
                  : Container()
              : Container(),
          data.status == 1
              ? SessionManager.getUserTypeId() == "2"
                  ? Obx(() {
                      return SizedBox(
                          height: 60.h,
                          width: 90.w,
                          child: patientController.rxRequestStatus.value ==
                                  Status.loading
                              ? const CustomLoading()
                              : CustomElevatedButton(
                                  text: "Done",
                                  onTap: () {
                                    
                                    patientController.patientAction(
                                        "3", data.id.toString());
                                  },
                                ));
                    })
                  : Container()
              : Container(),
          data.status == 2
              ? SessionManager.getUserTypeId() == "3"
                  ? Obx(() {
                      return SizedBox(
                          height: 60.h,
                          width: 90.w,
                          child: patientController.rxRequestStatus.value ==
                                  Status.loading
                              ? const CustomLoading()
                              : CustomElevatedButton(
                                  text: "Complete",
                                  onTap: () {
                                    patientController.patientAction(
                                        "1", data.id.toString());
                                  },
                                ));
                    })
                  : Container()
              : Container()
          // Row(
          //   children: [
          //     SizedBox(
          //         width: 120.w,
          //         height: 40.h,
          //         child: CustomElevatedButton(
          //           text: "Approve",
          //           onTap: () {},
          //         )),
          //     Spacer(),
          //     SizedBox(
          //         width: 110.w,
          //         height: 40.h,
          //         child: CustomElevatedButton(
          //           buttonStyle: ElevatedButton.styleFrom(
          //               backgroundColor: AppColors.red600D8,
          //               shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(10.h))),
          //           text: "Reject",
          //           onTap: () {},
          //         )),
          //   ],
          // )
        ]),
      ),
    );
  }

  buildFieldWidget([helper, value, color]) {
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
              style: AppTextStyles.text16Black600.copyWith(
                  color: color ?? AppColors.black121212,
                  fontWeight: FontWeight.bold),
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
