import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pvi_nhm/controllers/patient_controller.dart';
import 'package:pvi_nhm/widgets/app_bar_container.dart';
import '../../../controllers/auth_controller.dart';
import '../../../core/constants/app_export.dart';
import '../../../core/constants/session_manager.dart';
import '../../../core/routes/app_routes.dart';
import '../../../data/apiClient/http_response.dart';
import '../../../theme/color_constants.dart';
import '../../../theme/text_style.dart';
import '../../../utils/custom_toast.dart';
import '../../../widgets/custom_circuler_loader.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/reasign_surgery_card.dart';
import 'search_controller/assigned_list_search.dart';

class AssignedSurgeryScreen extends StatefulWidget {
  final String? id;
  const AssignedSurgeryScreen({super.key, this.id});

  @override
  State<AssignedSurgeryScreen> createState() => _AssignedSurgeryScreenState();
}

class _AssignedSurgeryScreenState extends State<AssignedSurgeryScreen> {
  final ReassignedListSearchController reassignedSearchController =
      Get.put(ReassignedListSearchController());
  final PatientController patientController = Get.put(PatientController());
  final AuthController authController = Get.put(AuthController());
  var data = Get.arguments;
  @override
  void initState() {
    toast.init(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      patientController.reassignSurgeries(data);
      // authController.getSpecialization();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        return SizedBox(
          height: size.height,
          width: double.infinity,
          child: Column(children: [
            Expanded(
                child: Stack(alignment: Alignment.center, children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: appBarContainer(
                  size,
                  title: "Reassigned Surgery",
                  isLeading: true,
                  leading: IconButton(
                      onPressed: () {
                        Get.offAllNamed(AppRoutes.DASHBOARD, arguments: [1, 0]);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      )),
                ),
              ),
              Positioned(
                bottom: -40.h,
                right: -15.w,
                child: SvgPicture.asset("assets/svg/Rectangle 5904.svg"),
              ),
              Positioned(
                  top: 120.h,
                  left: 20.w,
                  right: 20.w,
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 7,
                      )
                    ]),
                    child: CustomTextFormField(
                      fillColor: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      suffix: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: reassignedSearchController
                                    .searchQuery.value.isEmpty
                                ? AppColors.whiteA700
                                : AppColors.gray,
                          ),
                          onPressed: reassignedSearchController.clearData),
                      prefix: Padding(
                        padding: EdgeInsets.all(12.0.r),
                        child: SvgPicture.asset(
                          "assets/svg/search.svg",
                        ),
                      ),
                      hintText: "Search",
                      controller: reassignedSearchController.searchController,
                      onChanged: reassignedSearchController.updateSearchQuery,
                    ),
                  )),
              Positioned(
                  top: SessionManager.getUserTypeId() == "2" ||
                          SessionManager.getUserTypeId() == "3"
                      ? 200.h
                      : 280.h,
                  right: 10.w,
                  left: 10.w,
                  bottom: 0.h,
                  child: Obx(() {
                    var filteredPatient =
                        reassignedSearchController.filteredPatients;
                    if (patientController.rxRequestStatus.value ==
                        Status.loading) {
                      return const CustomLoading();
                    } else if (filteredPatient.isEmpty) {
                      return Center(
                        child: Text(
                          'No surgery found !',
                          style: AppTextStyles.headline,
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(0.0),
                      itemCount: filteredPatient.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var data = filteredPatient[index];

                        return ReassignSurgeryCard(
                          onTap: () {
                            Get.toNamed(AppRoutes.Assigned_Surgery_Details,
                                arguments: data);
                          },
                          name: data.patient.patientName,
                          designation: data.patient.electiveSurgery,
                        
                          description: data.description,
                          status: data.status,
                          title: data.title,
                          age: data.patient.age,
                          date: data.dateTime,
                          approvalDoc: SessionManager.getUserTypeId() == "3"
                              ? "Approval : ${data.approver.name.toString()}"
                              : SessionManager.getUserTypeId() == "2"
                                  ? "Doctor :  ${data.doctor.name.toString()}"
                                  : SessionManager.getUserTypeId() == "1"
                                      ? "Approval : ${data.approver.name.toString()}"
                                      : null,
                          secondApDoc: SessionManager.getUserTypeId() == "1"
                              ? "Doctor :  ${data.doctor.name.toString()}"
                              : null,
                        );
                      },
                    );
                  })),
              SessionManager.getUserTypeId() == "2" ||
                      SessionManager.getUserTypeId() == "3"
                  ? Container()
                  : Positioned(
                      top: 200.h,
                      right: 10.w,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.Reassign_Surgery);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.kprimary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            "Reassign Surgery +",
                            style: AppTextStyles.text18Black600
                                .copyWith(color: AppColors.kprimary),
                          ),
                        ),
                      )),
            ])),
          ]),
        );
      }),
    );
  }
}
