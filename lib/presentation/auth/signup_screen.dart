// ignore_for_file: avoid_print
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_export.dart';
import '../../core/routes/app_routes.dart';
import '../../data/apiClient/http_response.dart';
import '../../theme/color_constants.dart';
import '../../theme/text_style.dart';
import '../../utils/custom_toast.dart';
import '../../utils/validation_functions.dart';
import '../../widgets/app_bar_container.dart';
import '../../widgets/custom_circuler_loader.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../controllers/auth_controller.dart';

enum Gender { male, female }

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  AuthController authController = Get.put(AuthController());
  Gender gender = Gender.male;
  List<dynamic> accountTypeList = [
    {
      "id": 1,
      "name": "Doctor",
    },
    {
      "id": 2,
      "name": "Approver",
    },
    {
      "id": 3,
      "name": "Admin",
    },
  ];

  List<String> hospitals = [];
 
  final _formKey = GlobalKey<FormState>();

  // hospitalListData() async {
  //   Hospital? data = await authController.getHospitals();
  //   for (var i in data!.data!) {
  //     hospitals.add("${i.name.toString()}");
  //   }
  // }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    
    });
    toast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: Text(
              "Sign up",
              style: AppTextStyles.text16Black600
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 20.sp),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            expandedHeight: 100.h,
            // collapsedHeight: 70.h,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: appBarContainer(size),
            ),
          ),
          SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    if (authController.rxRequestStatus.value ==
                        Status.loading) {
                      return const CustomLoading();
                    }
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Column(
                        children: [
                          CustomTextFormField(
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Username is required.";
                              }
                              return null;
                            },
                            controller: authController.nameController,
                            prefix: Icon(
                              Icons.person,
                              color: AppColors.kprimary,
                            ),
                            labelText: "Name",
                            hintText: "Name",
                          ),
                          SizedBox(height: 10.h),
                          // CustomDropdown(
                          //   prefix: CustomImageView(
                          //     svgPath: "assets/icons/hospital.svg",
                          //   ),
                          //   labelText: "Hospital",
                          //   validator: (p0) {
                          //     if (p0 == null) {
                          //       return "Please Select Hospital";
                          //     }
                          //     return null;
                          //   },
                          //   onChng: (data) {
                          //     for (var i in authController.hospitalList) {
                          //       if (i.name == data) {
                          //         authController.hospitalId = i.id.toString();
                          //       }
                          //     }
                          //   },
                          //   listName: authController.hospitalList
                          //       .map((e) => e.name!)
                          //       .toList(),
                          //   hintText: "Select Hospital",
                          // ),
                          // SizedBox(height: 10.h),
                          // CustomDropdown(
                          //   prefix: CustomImageView(
                          //     svgPath: "assets/icons/hospital.svg",
                          //   ),
                          //   labelText: "Specialization",
                          //   validator: (p0) {
                          //     if (p0 == null) {
                          //       return "Specialization is required.";
                          //     }
                          //     return null;
                          //   },
                          //   listName: authController.specializationList
                          //       .map((e) => e.name!)
                          //       .toList(),
                          //   hintText: "Select Specialization",
                          //   onChng: (data) {
                          //     for (var i in authController.specializationList) {
                          //       if (i.name == data) {
                          //         authController.specializationId =
                          //             i.id.toString();
                          //       }
                          //     }
                          //   },
                          // ),
                          SizedBox(height: 10.h),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Gender",
                                      style: AppTextStyles.textFieldLabel,
                                    ),
                                    SizedBox(width: 2.w),
                                    CustomImageView(
                                      svgPath: "assets/icons/gender.svg",
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      activeColor: AppColors.kprimary,
                                      value: Gender.male,
                                      groupValue: gender,
                                      onChanged: (value) {
                                        // authController.genderChange(value);
                                        setState(() {
                                          gender = value!;
                                        });
                                      },
                                    ),
                                    Text(
                                      "Male",
                                      style: AppTextStyles.text12WhiteRegular
                                          .copyWith(
                                              color: const Color(0xff121212),
                                              fontWeight: FontWeight.w400),
                                    ),
                                    const Spacer(),
                                    Radio(
                                      activeColor: AppColors.kprimary,
                                      value: Gender.female,
                                      groupValue: gender,
                                      onChanged: (value) {
                                        //authController.genderChange(value);
                                        setState(() {
                                          gender = value!;
                                        });
                                      },
                                    ),
                                    Text(
                                      "Female",
                                      style: AppTextStyles.text12WhiteRegular
                                          .copyWith(
                                              color: const Color(0xff121212),
                                              fontWeight: FontWeight.w400),
                                    ),
                                    const Spacer()
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          CustomTextFormField(
                            validator: emailValidator,
                            controller: authController.emailController,
                            prefix:
                                Icon(Icons.email, color: AppColors.kprimary),
                            labelText: "Email",
                            hintText: "Email",
                          ),
                          SizedBox(height: 10.h),
                          CustomTextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter phone no.";
                              }
                              return null;
                            },
                            maxLength: 10,
                            textInputType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: authController.phoneController,
                            prefix:
                                Icon(Icons.phone, color: AppColors.kprimary),
                            labelText: "Phone",
                            hintText: "Phone",
                          ),
                          SizedBox(height: 10.h),
                          CustomTextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter resgistration no.";
                              }
                              return null;
                            },
                            controller: authController.registrationNoController,
                            prefix:
                                Icon(Icons.badge, color: AppColors.kprimary),
                            labelText: "Resgistration No.",
                            hintText: "Resgistration No.",
                          ),
                          SizedBox(height: 10.h),
                          CustomTextFormField(
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Please enter your address";
                              }
                              return null;
                            },
                            controller: authController.addressController,
                            maxLines: 2,
                            // prefix:
                            //     Icon(Icons.home, color: AppColors.kprimary),
                            labelText: "Address",
                            hintText: "Address",
                          ),
                          SizedBox(height: 20.h),
                          authController.rxRequestStatus.value == Status.loading
                              ? const CustomLoading()
                              : CustomElevatedButton(
                                  text: "Submit",
                                  onTap: () {
                                    print(gender.name.toString());
                                    if (_formKey.currentState!.validate()) {
                                      authController.signUp(gender.name);
                                    }
                                  }),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            width: MediaQuery.of(Get.context!).size.width,
                            alignment: Alignment.center,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80.w,
                                    height: 3.h,
                                    color: Colors.grey,
                                  ),
                                  const Text(
                                    " OR ",
                                    style: AppTextStyles.smallText,
                                  ),
                                  Container(
                                    width: 80.w,
                                    height: 3,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(Get.context!).size.width,
                            alignment: Alignment.center,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Already have an account?',
                                      style: AppTextStyles.smallText
                                          .copyWith(fontSize: 16)),
                                  TextButton(
                                    onPressed: () {
                                      Get.toNamed(AppRoutes.LOGIN);
                                    },
                                    child: Text(
                                      "Login",
                                      style: AppTextStyles.smallText.copyWith(
                                          fontSize: 16,
                                          color: AppColors.kprimary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
