import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pvi_nhm/controllers/user_controller.dart';
import 'package:pvi_nhm/data/model/user_model.dart';
import '../../../core/constants/app_export.dart';
import '../../../data/apiClient/http_response.dart';
import '../../../theme/color_constants.dart';
import '../../../theme/text_style.dart';
import '../../../utils/validation_functions.dart';
import '../../../widgets/app_bar_container.dart';
import '../../../widgets/custom_circuler_loader.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_image_view.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../controllers/auth_controller.dart';
import '../../auth/signup_screen.dart';

enum Verify { yes, no }

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  UserController userController = Get.put(UserController());

  AuthController authController = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();
  Gender gender = Gender.male;
  Verify verify = Verify.yes;
  List<UserModel> users = [UserModel("Doctor", "3"), UserModel("Approval", "2")];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: double.infinity,
          child: Column(children: [
            Expanded(
                child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: appBarContainer(
                    size,
                    title: "Add User",
                    isLeading: true,
                  ),
                ),
                Positioned(
                  bottom: -40.h,
                  right: -15.w,
                  child: SvgPicture.asset("assets/svg/Rectangle 5904.svg"),
                ),
                Positioned(
                    top: 140.h,
                    right: 15.w,
                    left: 15.w,
                    bottom: 15.h,
                    child: addUserForm(size)),
              ],
            ))
          ]),
        ),
      ),
    );
  }

  addUserForm(size) {
    return Obx(() {
      if (authController.rxRequestStatus.value == Status.loading) {
        return const CustomLoading();
      }
      return Container(
        height: size.height,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
            color: AppColors.whiteA700,
            borderRadius: BorderRadius.circular(25.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.gray.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 7,
              )
            ]),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              CustomTextFormField(
                hintText: "Name",
                labelText: "Name",
                prefix: Icon(Icons.phone, color: AppColors.gray),
                // prefix: Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: SvgPicture.asset("assets/icons/person.svg"),
                // ),
                controller: userController.nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.h),
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
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                        Text(
                          "Male",
                          style: AppTextStyles.text12WhiteRegular.copyWith(
                              color: const Color(0xff121212),
                              fontWeight: FontWeight.w400),
                        ),
                        const Spacer(),
                        Radio(
                          activeColor: AppColors.kprimary,
                          value: Gender.female,
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                        Text(
                          "Female",
                          style: AppTextStyles.text12WhiteRegular.copyWith(
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
              CustomDropdown(
                // prefix: CustomImageView(
                //   svgPath: "assets/icons/hospital.svg",
                // ),
                labelText: "User Type",
                validator: (p0) {
                  if (p0 == null) {
                    return "User type is required.";
                  }
                  return null;
                },
                listName: users.map((e) => e.name!).toList(),
                hintText: "Select User Type",
                onChng: (data) {
                  for (var i in users) {
                    if (i.name == data) {
                      authController.userTypeId = i.id.toString();
                    }
                  }
                },
              ),

              SizedBox(height: 10.h),
              CustomTextFormField(
                  labelText: "Phone number",
                  hintText: "Phone number",
                  controller: userController.phoneController,
                  maxLength: 10,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  prefix: Icon(Icons.phone, color: AppColors.gray),
                  textInputType: TextInputType.number,
                  validator: phoneNumberValidator),
              SizedBox(height: 10.h),
              CustomTextFormField(
                  hintText: "E-mail",
                  labelText: "E-mail",
                  controller: userController.emailController,
                  prefix: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset("assets/icons/email.svg"),
                  ),
                  validator: emailValidator),
              SizedBox(height: 10.h),
              CustomTextFormField(
                hintText: "Registration No.",
                labelText: "Registration No.",
                controller: userController.registrationNoController,
                prefix: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset("assets/icons/edit_user.svg"),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter registration no.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                hintText: "Address",
                labelText: "Adress",
                controller: userController.addressController,
                prefix: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset("assets/icons/edit_user.svg"),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter address";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                hintText: "Password",
                labelText: "Password",
                controller: userController.passwordController,
                prefix: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset("assets/icons/edit_user.svg"),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter password";
                  }
                  return null;
                },
              ),
              // SizedBox(height: 10.h),

              // Container(
              //   alignment: Alignment.centerLeft,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Row(
              //         children: [
              //           Text(
              //             "Verified",
              //             style: AppTextStyles.textFieldLabel,
              //           ),
              //           SizedBox(width: 4.w),
              //           CustomImageView(
              //             svgPath: "assets/icons/verify.svg",
              //           )
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Radio(
              //             activeColor: AppColors.kprimary,
              //             value: Verify.yes,
              //             groupValue: verify,
              //             onChanged: (value) {
              //               setState(() {
              //                 verify = value!;
              //               });
              //             },
              //           ),
              //           Text(
              //             "Yes",
              //             style: AppTextStyles.text12WhiteRegular.copyWith(
              //                 color: const Color(0xff121212),
              //                 fontWeight: FontWeight.w400),
              //           ),
              //           const Spacer(),
              //           Radio(
              //             activeColor: AppColors.kprimary,
              //             value: Verify.no,
              //             groupValue: verify,
              //             onChanged: (value) {
              //               setState(() {
              //                 verify = value!;
              //               });
              //             },
              //           ),
              //           Text(
              //             "No",
              //             style: AppTextStyles.text12WhiteRegular.copyWith(
              //                 color: const Color(0xff121212),
              //                 fontWeight: FontWeight.w400),
              //           ),
              //           const Spacer()
              //         ],
              //       )
              //     ],
              //   ),
              // ),
              SizedBox(height: 10.h),
              userController.rxRequestStatus.value == Status.loading
                  ? const CustomLoading()
                  : CustomElevatedButton(
                      text: "Submit",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          userController.addUser(verify.name, gender.name);
                        }
                      },
                    )
            ],
          ),
        ),
      );
    });
  }
}
