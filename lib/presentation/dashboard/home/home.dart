import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pvi_nhm/controllers/patient_controller.dart';
import 'package:pvi_nhm/widgets/doctor_card_widget.dart';
import '../../../../core/constants/exit_app.dart';
import 'package:intl/intl.dart';
import '../../../controllers/notification_controller.dart';
import '../../../core/constants/api_network.dart';
import '../../../core/constants/app_export.dart';
import '../../../core/constants/session_manager.dart';
import '../../../core/routes/app_routes.dart';
import '../../../data/apiClient/http_response.dart';
import '../../../theme/color_constants.dart';
import '../../../theme/gradient.dart';
import '../../../theme/text_style.dart';
import '../../../utils/custom_toast.dart';
import '../../../utils/empty_container.dart';
import '../../../widgets/custom_circuler_loader.dart';
import '../../../widgets/custom_image_view.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  // CarouselController buttonCarouselController = CarouselController();
  PatientController patientController = Get.put(PatientController());
  // RequestController requestController = Get.put(RequestController());
  // NotificationController notificationController =
  //     Get.put(NotificationController());

  // ignore: prefer_typing_uninitialized_variables
  var _user;
  @override
  void initState() {
    _user = json.decode(SessionManager.getUser().toString());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      patientController.getPatient();
      homeController.getDashboard();
      SessionManager.getUserTypeId() == "2" ||
              SessionManager.getUserTypeId() == "3"
          ? patientController.reassignSurgeries()
          : null;
      // notificationController.getNotification();
    });

    toast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var userType = SessionManager.getUserTypeId();

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () => backButtonPressed(context),
      child: Scaffold(
        body: Obx(() {
          return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  left: -91.w,
                  top: -73.h,
                  child: Container(
                    width: 342.w,
                    height: 342.h,
                    decoration: ShapeDecoration(
                      gradient: AppGradient.kCircleGradient(),
                      shape: const OvalBorder(),
                    ),
                  ),
                ),
                Positioned(
                    child: SvgPicture.asset(
                  "assets/icons/elips_circle.svg",
                )),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  bottom: homeController.isExpanded.value ? 0 : 0,
                  top: homeController.isExpanded.value ? 0 : 60.h,
                  left: homeController.isExpanded.value ? 0 : 37.w,
                  right: homeController.isExpanded.value ? 0 : 0,
                  child: GestureDetector(
                    onPanUpdate: homeController.onPanUpdate,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        color: AppColors.whiteA700,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              homeController.isExpanded.value ? 0 : 40.r),
                        ),
                      ),
                      child: CustomScrollView(
                        shrinkWrap: true, // Added to prevent overflow
                        physics: homeController.isExpanded.value
                            ? const BouncingScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        slivers: [
                          SliverAppBar(
                            title: _buildUserCard(),
                            backgroundColor: homeController.isExpanded.value
                                ? Colors.white
                                : Colors.transparent,
                            expandedHeight:
                                homeController.isExpanded.value ? 500.h : 480.h,
                            pinned: true,
                            snap: false,
                            flexibleSpace: FlexibleSpaceBar(
                              background: Container(
                                color: homeController.isExpanded.value
                                    ? Colors.white
                                    : Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SessionManager.getUserTypeId() == "2"
                                        ? _buildHospitalCard()
                                        : _buildDoctorCard(),
                                    SizedBox(height: 10.h),
                                    _buildCategorySection(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 10.w,
                                top: 10.w,
                                bottom: 10.h,
                                right: 10.w,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: Text(
                                      SessionManager.getUserTypeId() == "2" ||
                                              SessionManager.getUserTypeId() ==
                                                  "3"
                                          ? "Assiged Patient"
                                          : "Patient",
                                      style: AppTextStyles.text32Black600
                                          .copyWith(fontSize: 22.sp),
                                    ),
                                  ),
                                  SessionManager.getUserTypeId() == "2" ||
                                          SessionManager.getUserTypeId() == "3"
                                      ? _buildReassignedPatient(size)
                                      : _buildUpcomingAppointments(size),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  _buildUpcomingAppointments(Size size) {
    return Obx(() {
      if (patientController.rxRequestStatus.value == Status.loading) {
        return SizedBox(
            height: size.height * 0.3,
            child: const Center(child: CustomLoading()));
      }
      if (patientController.patientList.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: EmptyContainer(
            msg: "Currently you don't have patients",
          ),
        );
      }
      return SizedBox(
        height: size.height / 1.30,
        child: ListView.builder(
            padding:const EdgeInsets.all(0.0),
            itemCount: patientController.patientList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var upcomingPatientList = patientController.patientList[index];

              // DateTime surgeryDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
              //     .parse(upcomingPatientList..surgeryDate!);
              final dateFormat = DateFormat('dd');
              final dateDay = DateFormat('EEE');
              // final formattedDate =
              //     dateFormat.format(surgeryDate).toUpperCase();
              // final formattedDay = dateDay.format(surgeryDate).toUpperCase();
              return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  margin: EdgeInsets.only(
                      bottom: 5.h, right: 10.w, left: 10.w, top: 10.h),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    // color: AppColors.ksecondaryColor,
                    borderRadius: BorderRadius.circular(
                      15.r,
                    ),
                  ),
                  child: DoctorCardWidget(
                    onTap: () {
                      Get.toNamed(AppRoutes.Assigned_Surgery,
                          arguments: upcomingPatientList.id);
                    },
                    name: upcomingPatientList.patientName,
                    designation: upcomingPatientList.electiveSurgery,
                    gender: upcomingPatientList.gender,
                    status: upcomingPatientList.status,
                    approvalDoc: SessionManager.getUserTypeId() == "3"
                        ? "Approval : ${upcomingPatientList.approver.name.toString()}"
                        : SessionManager.getUserTypeId() == "2"
                            ? "Doctor :  ${upcomingPatientList.doctor.name.toString()}"
                            : SessionManager.getUserTypeId() == "1"
                                ? "Approval : ${upcomingPatientList.approver.name.toString()}"
                                : null,
                    secondApDoc: SessionManager.getUserTypeId() == "1"
                        ? "Doctor :  ${upcomingPatientList.doctor.name.toString()}"
                        : null,
                  ));
            }),
      );
    });
  }

  _buildReassignedPatient(Size size) {
    return Obx(() {
      if (patientController.rxRequestStatus.value == Status.loading) {
        return SizedBox(
            height: size.height * 0.3, child: Center(child: CustomLoading()));
      }
      if (patientController.assignedSurgeryList.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: EmptyContainer(
            msg: "Currently you don't have surgeries",
          ),
        );
      }
      return SizedBox(
        height: size.height / 1.25,
        child: ListView.builder(
            padding: const EdgeInsets.all(0.0),
            itemCount: patientController.assignedSurgeryList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var upcomingPatientList =
                  patientController.assignedSurgeryList[index];

              // DateTime surgeryDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
              //     .parse(upcomingPatientList..surgeryDate!);
              final dateFormat = DateFormat('dd');
              final dateDay = DateFormat('EEE');
              // final formattedDate =
              //     dateFormat.format(surgeryDate).toUpperCase();
              // final formattedDay = dateDay.format(surgeryDate).toUpperCase();
              return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  margin: EdgeInsets.only(
                      bottom: 5.h, right: 10.w, left: 10.w, top: 10.h),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    // color: AppColors.ksecondaryColor,
                    borderRadius: BorderRadius.circular(
                      15.r,
                    ),
                  ),
                  child: DoctorCardWidget(
                    onTap: () {
                      Get.toNamed(AppRoutes.Assigned_Surgery_Details,
                          arguments: upcomingPatientList);
                    },
                    title: upcomingPatientList.title,
                    age: upcomingPatientList.patient.age,
                    date: upcomingPatientList.dateTime,
                    name: upcomingPatientList.patient.patientName,
                    designation: upcomingPatientList.patient.electiveSurgery,
                    gender: upcomingPatientList.patient.gender,
                    status: upcomingPatientList.status,
                    approvalDoc: SessionManager.getUserTypeId() == "3"
                        ? "Approval : ${upcomingPatientList.approver.name.toString()}"
                        : SessionManager.getUserTypeId() == "2"
                            ? "Doctor :  ${upcomingPatientList.doctor.name.toString()}"
                            : SessionManager.getUserTypeId() == "1"
                                ? "Approval : ${upcomingPatientList.approver.name.toString()}"
                                : null,
                    secondApDoc: SessionManager.getUserTypeId() == "1"
                        ? "Doctor :  ${upcomingPatientList.doctor.name.toString()}"
                        : null,
                  ));
            }),
      );
    });
  }

  Container _buildCategorySection() {
    return Container(
      margin: EdgeInsets.only(left: 15.w, right: 15.w),
      child: GetBuilder(
          init: homeController,
          builder: (context) {
            List doctorOperation = [
              if (SessionManager.getUserTypeId() == "1")
                {
                  "name": "Doctor",
                  "image": "assets/svg/vaadin--doctor.svg",
                  "value": homeController.totalDoc,
                  "route": AppRoutes.All_DOC
                },
              if (SessionManager.getUserTypeId() == "1")
                {
                  "name": "Supervisor",
                  "image": "assets/svg/material-symbols--order-approve.svg",
                  "value": homeController.supervisor,
                  "route": AppRoutes.ALL_SUP
                },
              {
                "name": "Patient",
                "image": "assets/svg/mdi--patient-outline.svg",
                "value": homeController.totalPatient,
                "route": AppRoutes.ALL_PATIENT
              },
              {
                "name": "Completed",
                "image": "assets/svg/material-symbols--order-approve.svg",
                "value": homeController.completes,
                "route": AppRoutes.COMPLETE_PATIENT
              },
              {
                "name": "Pending",
                "image": "assets/icons/all_request.svg",
                "value": homeController.pending,
                "route": AppRoutes.PANDING_PATIENT
              },
              {
                "name": "Done",
                "image": "assets/svg/lets-icons--done-duotone.svg",
                "value": homeController.done,
                "route": AppRoutes.ALL_DONE
              },
            ];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: homeController.isExpanded.value ? 180.h : 180.h,
                  width: double.infinity,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                          mainAxisExtent: 80.h,
                          crossAxisCount: 3),
                      padding: const EdgeInsets.all(0.0),
                      scrollDirection: Axis.vertical,
                      physics: homeController.isExpanded.value
                          ? const BouncingScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      itemCount: doctorOperation.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(doctorOperation[index]['route'],
                                arguments: [0, 0]);
                          },
                          splashColor: AppColors.whiteA700,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width:
                                homeController.isExpanded.value ? 110.w : 100.w,
                            margin: EdgeInsets.only(right: 16.w, left: 16.w),
                            decoration: BoxDecoration(
                                color: AppColors.whiteA700,
                                borderRadius: BorderRadius.circular(15.r)),
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(15.h),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.kprimary
                                            .withOpacity(0.3)),
                                    // height: 86.h,
                                    // decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(17.r),
                                    //     border: Border.all(
                                    //       color: AppColors.black900.withOpacity(0.2),
                                    //       width: 1,
                                    //     )),
                                    child: CustomImageView(
                                      svgPath: doctorOperation[index]['image'],
                                      height: 35.h,
                                      color: AppColors.kprimary,
                                    )),
                                Positioned(
                                  top: 65.h,
                                  child: Container(
                                    width: 100.w,
                                    height: 35.h,
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      doctorOperation[index]['name'],
                                      //softWrap: true,
                                      style: AppTextStyles.text10DarkGreen400
                                          .copyWith(fontSize: 12.sp),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10.h,
                                  right: 5.w,
                                  child: Container(
                                    padding: EdgeInsets.all(8.h),
                                    alignment: Alignment.topCenter,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.red600D8),
                                    child: Text(
                                      _getDisplayValue(
                                          doctorOperation[index]['value']),

                                      //softWrap: true,
                                      style: AppTextStyles.text14White400
                                          .copyWith(fontSize: 12.sp),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            );
          }),
    );
  }

  String _getDisplayValue(dynamic value) {
    int intValue = int.tryParse(value) ?? 0;
    if (intValue > 100) {
      return '100+';
    } else if (intValue > 10) {
      return '10+';
    } else {
      return value.toString();
    }
  }

  _buildHospitalCard() {
    List<Widget> items = [
      sliderCardHospital(),
    ];
    return CarouselSlider(
        items: items,
        options: CarouselOptions(
          autoPlay: items.length > 1,
          aspectRatio: homeController.isExpanded.value ? 1.7.h : 1.62.h,
          viewportFraction: 1,
          enlargeCenterPage: true,
          enableInfiniteScroll: items.length > 1,
          scrollPhysics:
              items.length > 1 ? null : const NeverScrollableScrollPhysics(),
        ));

    sliderCardHospital();
  }

  sliderCardHospital() {
    return Container(
      height: 200.h,
      margin: EdgeInsets.only(
        left: 12.w,
        right: 12.w,
        top: 130.h,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.hospitalCardColor,
          borderRadius: BorderRadius.circular(15.r)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              width: 180.w,
              duration: const Duration(milliseconds: 500),
              child: Column(
                children: [
                  Text(
                    "Medical Center",
                    style: AppTextStyles.text18White600.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Yorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.",
                    textAlign: TextAlign.start,
                    style: AppTextStyles.text10White400,
                  )
                ],
              ),
            ),
          ],
        ),
        Image.asset(
          "assets/images/doctor.png",
        ),
      ]),
    );
  }

  _buildDoctorCard() {
    List<Widget> items = [
      sliderCardDoctor(),
    ];
    return CarouselSlider(
        items: items,
        options: CarouselOptions(
          autoPlay: items.length > 1,
          aspectRatio: homeController.isExpanded.value ? 1.46 : 1.4,
          viewportFraction: 1,
          enlargeCenterPage: true,
          enableInfiniteScroll: items.length > 1,
          scrollPhysics:
              items.length > 1 ? null : const NeverScrollableScrollPhysics(),
        ));

    sliderCardDoctor();
  }

  Container sliderCardDoctor() {
    return Container(
      height: 200.h,
      margin: EdgeInsets.only(
        left: 12.w,
        right: 20.w,
        top: 100.h,
      ),
      width: double.infinity,
      child: Stack(children: [
        Positioned(
          bottom: 0.h,
          left: 0.w,
          right: 0.w,
          top: 25.h,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.whiteA700,
                gradient: AppGradient.kContainerGradient(),
                borderRadius: BorderRadius.circular(15.r)),
          ),
        ),
        Positioned(
          top: 64.h,
          left: 20.w,
          child: AnimatedContainer(
            width: 162.w,
            duration: const Duration(milliseconds: 500),
            child: Column(
              children: [
                Text(
                  "Get the Best Medical Services",
                  textAlign: TextAlign.left,
                  style: AppTextStyles.text17PersianGreen700,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "We provide best quality medical services without further cost",
                  textAlign: TextAlign.left,
                  style: AppTextStyles.text9black400,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: -10.w,
          top: -30.h,
          bottom: -25.h,
          left: 162.w,
          child: Image.asset(
            "assets/images/doctor.png",
          ),
        ),
      ]),
    );
  }

  ListTile _buildUserCard() {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 10.w, right: 10.h),
      title: Text(
        "Hi, Welcome",
        style: AppTextStyles.text16Black400,
      ),
      subtitle: Text(
        _user['name'].toString().capitalizeFirst!,
        style: AppTextStyles.text32Black600.copyWith(fontSize: 24.sp),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.NOTIFICATION);
            },
            child: SizedBox(
              height: 50.h,
              width: 35.w,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CustomImageView(
                      svgPath: "assets/icons/notification.svg",
                      height: 45.h,
                      width: 45.w,
                    ),
                  ),
                  unreadNotification == 0 || unreadNotification == null
                      ? Container()
                      : Positioned(
                          top: 4.h,
                          left: 16.h,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.red600D8),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text("0",
                                  style: AppTextStyles.smallText.copyWith(
                                      fontSize: 8, color: AppColors.whiteA700)),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.PROFILE);
            },
            child: CircleAvatar(
              radius: 27.r,
              backgroundColor: AppColors.kprimary.withOpacity(0.1),
              backgroundImage: _user['avatar'] == null
                  ? const AssetImage("assets/images/user_avatar.png")
                  : NetworkImage(ApiNetwork.imageUrl + _user['avatar'])
                      as ImageProvider,
            ),
          ),
        ],
      ),
    );
  }
}
