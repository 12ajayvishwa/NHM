import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pvi_nhm/widgets/doctor_card_widget.dart';
import '../../../../core/constants/app_export.dart';
import '../../../controllers/patient_controller.dart';
import '../../../core/constants/session_manager.dart';
import '../../../core/routes/app_routes.dart';
import '../../../data/apiClient/http_response.dart';
import '../../../theme/color_constants.dart';
import '../../../theme/text_style.dart';
import '../../../utils/custom_toast.dart';
import '../../../widgets/app_bar_container.dart';
import '../../../widgets/custom_circuler_loader.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../controllers/auth_controller.dart';
import 'search_function.dart';

class PatientScreen extends StatefulWidget {
  PatientScreen({super.key});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  final PatientSearchController doctorSearchController =
      Get.put(PatientSearchController());
  final PatientController patientController = Get.put(PatientController());
  final AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    toast.init(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      patientController.getPatient();
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
        print("z${doctorSearchController.filteredPatients.length}");
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
                child: appBarContainer(size, title: "Patients"),
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
                            color:
                                doctorSearchController.searchQuery.value.isEmpty
                                    ? AppColors.whiteA700
                                    : AppColors.gray,
                          ),
                          onPressed: doctorSearchController.clearData),
                      prefix: Padding(
                        padding: EdgeInsets.all(12.0.r),
                        child: SvgPicture.asset(
                          "assets/svg/search.svg",
                        ),
                      ),
                      hintText: "Search",
                      controller: doctorSearchController.searchController,
                      onChanged: doctorSearchController.updateSearchQuery,
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
                        doctorSearchController.filteredPatients;
                    if (patientController.rxRequestStatus.value ==
                        Status.loading) {
                      return const CustomLoading();
                    } else if (filteredPatient.isEmpty) {
                      return Center(
                        child: Text(
                          'No Patient found !',
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

                        return DoctorCardWidget(
                          onTap: () {
                          Get.toNamed(AppRoutes.Assigned_Surgery,
                          arguments: data.id);
                          },
                          name: data.patientName,
                          designation: data.electiveSurgery,
                          gender: data.gender,
                          status: data.status,
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
                          Get.toNamed(AppRoutes.ADD_PATIENT);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.kprimary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            "Add Patient +",
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
