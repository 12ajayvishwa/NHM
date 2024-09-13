
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../controllers/setting_controller.dart';
import '../../../../core/constants/app_export.dart';
import '../../../../theme/color_constants.dart';
import '../../../../theme/text_style.dart';
import '../../../../utils/validation_functions.dart';
import '../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_image_view.dart';
import '../../../../widgets/custom_text_form_field.dart';
// ignore: must_be_immutable
class ContactSupportScreen extends StatelessWidget {
  ContactSupportScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteA700,
      appBar: CustomAppBar(
        title: "Contact Support",
        centerTitle: true,
        elevation: 0,
        isLeading: true,
        onPressed: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Any question or remarks?\nJust write us a message!",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.text16Gray400,
                  ),
                ),
                Container(
                  height: 366.h,
                  width: double.maxFinite,
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  decoration: BoxDecoration(
                      color: AppColors.ksecondaryColor,
                      borderRadius: BorderRadius.circular(4.r)),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Column(
                            children: [
                              Text(
                                "Contact Information",
                                style: AppTextStyles.text20WhiteSemiBold,
                              ),
                              Text(
                                "Get In Touch",
                                style: AppTextStyles.text11WhiteRegular,
                              ),
                              _buildContact(
                                  icon: "assets/icons/bxs_phone-call.svg",
                                  title1: "+1 234 567 89",
                                  title2: "+1 234 567 89"),
                              _buildContact(
                                  icon: "assets/icons/ic_sharp-email.svg",
                                  title1: "demo@gmail.com",
                                  title2: "demo@gmail.com"),
                              _buildContact(
                                icon: "assets/icons/carbon_location-filled.svg",
                                title1:
                                    "132 Dartmouth Street Boston, Massachusetts 02156 United States",
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          right: -77.w,
                          bottom: -77.h,
                          child: SvgPicture.asset(
                            "assets/images/Ellipse.svg",
                            height: 153.h,
                          )),
                      Positioned(
                          right: 30.w,
                          bottom: 30.h,
                          child: SvgPicture.asset(
                            "assets/images/Ellipse.svg",
                            height: 54.h,
                          )),
                      // Positioned(
                      //     left: -77.w,
                      //     bottom: -77.h,
                      //     child: SvgPicture.asset(
                      //       "assets/images/Ellipse.svg",
                      //       height: 153.h,
                      //     )),
                      // Positioned(
                      //     left: 30.w,
                      //     bottom: 30.h,
                      //     child: SvgPicture.asset(
                      //       "assets/images/Ellipse.svg",
                      //       height: 54.h,
                      //     )),
                    ],
                  ),
                ),
                CustomTextFormField(
                  labelText: "Name",
                  hintText: "Enter Name",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                  textInputType: TextInputType.text,
                  controller: settingController.contactName.value,
                  prefix: const Icon(Icons.person_3_sharp),
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomTextFormField(
                  labelText: "Phone",
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  hintText: "Enter Phone No.",
                  maxLength: 10,
                  controller: settingController.contactPhoneNo.value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your phone number";
                    }
                    return null;
                  },
                  textInputType: TextInputType.phone,
                  prefix: const Icon(Icons.phone),
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomTextFormField(
                  labelText: "Email",
                  hintText: "Enter Email Id ",
                  validator: emailValidator,
                  textInputType: TextInputType.emailAddress,
                  controller: settingController.contactEmail.value,
                  prefix: const Icon(Icons.email),
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomTextFormField(
                  labelText: "Message",
                  hintText: "Message",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your message";
                    }
                    return null;
                  },
                  maxLines: 3,
                  textInputType: TextInputType.emailAddress,
                  controller: settingController.contactMessage.value,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                  child: CustomElevatedButton(
                    text: "Submit",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        settingController.contactAndSupport();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildContact({String? icon, String? title1, String? title2}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 20.h,
        ),
        CustomImageView(
          svgPath: icon,
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          width: 220.w,
          child: Text(
            title1!,
            textAlign: TextAlign.center,
            style: AppTextStyles.text12WhiteRegular,
          ),
        ),
        title2 != null
            ? Text(
                title2,
                style: AppTextStyles.text12WhiteRegular,
              )
            : Container(),
      ],
    );
  }
}
