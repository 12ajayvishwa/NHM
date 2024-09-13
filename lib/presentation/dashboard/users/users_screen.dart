import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pvi_nhm/widgets/doctor_card_widget.dart';
import '../../../../core/constants/app_export.dart';
import '../../../controllers/patient_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../core/constants/api_network.dart';
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

class UsersScreen extends StatefulWidget {
  UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final UserSearchController userSearchController =
      Get.put(UserSearchController());
  final UserController userController = Get.put(UserController());
  final AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    toast.init(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userController.clearData();
      userController.getUserList();
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
        print("Z${userSearchController.filteredPatients.length}");
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
                child: appBarContainer(size, title: "Users List"),
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
                                userSearchController.searchQuery.value.isEmpty
                                    ? AppColors.whiteA700
                                    : AppColors.gray,
                          ),
                          onPressed: userSearchController.clearData),
                      prefix: Padding(
                        padding: EdgeInsets.all(12.0.r),
                        child: SvgPicture.asset(
                          "assets/svg/search.svg",
                        ),
                      ),
                      hintText: "Search",
                      controller: userSearchController.searchController,
                      onChanged: userSearchController.updateSearchQuery,
                    ),
                  )),
              Positioned(
                  top: 280.h,
                  right: 10.w,
                  left: 10.w,
                  bottom: 0.h,
                  child: Obx(() {
                    var filteredPatient = userSearchController.filteredPatients;
                    if (userController.rxRequestStatus.value ==
                        Status.loading) {
                      return const CustomLoading();
                    } else if (filteredPatient.isEmpty) {
                      return Center(
                        child: Text(
                          'No User found !',
                          style: AppTextStyles.headline,
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: filteredPatient.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var data = filteredPatient[index];

                        return DoctorCardWidget(
                          onTap: () {
                              Get.toNamed(AppRoutes.PROFILEDETAL,
                                arguments: data);
                          },
                          name: data.name,
                          gender: data.gender,
                          imageUrl: data.avatar == null
                              ? null
                              : ApiNetwork.imageUrl + data.avatar,
                          designation: data.userTypeId == "2"
                              ? "Approval"
                              : data.userTypeId == "3"
                                  ? "Doctor"
                                  : "Admin",
                          isUserList: true,
                          secondApDoc: data.email ?? "",
                          phoneNumber: data.phone,

                        );
                      },
                    );
                  })),
              Positioned(
                  top: 200.h,
                  right: 10.w,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.ADD_USER);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.kprimary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        "Add User +",
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
