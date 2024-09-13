
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/setting_controller.dart';
import '../../core/constants/app_export.dart';
import '../../core/constants/api_network.dart';
import '../../core/constants/session_manager.dart';
import '../../data/apiClient/http_response.dart';
import '../../theme/color_constants.dart';
import '../../theme/text_style.dart';
import '../../utils/custom_toast.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_circuler_loader.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/image_picker.dart';
import '../auth/login_verification/controller/login_verification_controller.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? gender;
  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  SettingController settingController = Get.put(SettingController());
  LoginVerificationController controller =
      Get.put(LoginVerificationController());

  final _formKey = GlobalKey<FormState>();

  // ignore: prefer_typing_uninitialized_variables
  var _user;
  @override
  void initState() {
    _user = json.decode(SessionManager.getUser().toString());
    settingController.name.value.text = _user['name'] ?? '';
    settingController.designation.value.text = _user['designation'] ?? '';
    settingController.editPhone.value.text = _user['phone'] ?? '';
    settingController.editEmail.value.text = _user['email'] ?? '';
    settingController.registrationNo.value.text =
        _user['registration_no'] ?? '';
    // settingController.experience.value.text =
    //     _user['experience'] == null ? "" :_user['experience'];
    // SessionManager.getUserTypeId() == '2'
    //     ? null
    //     : settingController.specialization.value.text =
    //         _user['specialization']['name'].toString() ?? '';
    gender = _user['gender'];
    toast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userType = SessionManager.getUserTypeId();
    return Scaffold(
      appBar: CustomAppBar(
        title: "Edit Profile",
        isLeading: true,
        centerTitle: true,
        onPressed: () {
          Get.back();
        },
      ),
      body: Center(
        child: SingleChildScrollView(child: Obx(() {
          print(settingController.experience.value);
          switch (settingController.rxRequestStatus.value) {
            case Status.loading:
              return const CustomLoading();
            case Status.success:
              return Form(
                key: _formKey,
                child: Builder(builder: (context) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 70.h,
                            ),
                            Container(
                              //color: Colors.red,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 4,
                                        offset: const Offset(0, 0),
                                        blurRadius: 5)
                                  ]),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 80.h,
                                  ),
                                  buildFieldWidget(
                                      "Registration No.",
                                      settingController
                                          .registrationNo.value.text),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  detailsForm(
                                      "Name",
                                      CustomTextFormField(
                                        hintText: "Name",
                                        controller:
                                            settingController.name.value,
                                        prefix: Icon(
                                          Icons.person_2_outlined,
                                          color: AppColors.kprimary,
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your name';
                                          }
                                          return null;
                                        },
                                      )),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  userType == "2"
                                      ? Container()
                                      : detailsForm(
                                          "Gender",
                                          Row(
                                            children: [
                                              Expanded(
                                                child: RadioListTile(
                                                  contentPadding:
                                                      const EdgeInsets.all(0),
                                                  title: const Text("Male"),
                                                  value: "male",
                                                  groupValue: gender,
                                                  activeColor:
                                                      AppColors.kprimary,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      gender = value.toString();
                                                    });
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: RadioListTile(
                                                  contentPadding:
                                                      const EdgeInsets.all(0),
                                                  title: const Text("Female"),
                                                  value: "female",
                                                  groupValue: gender,
                                                  activeColor:
                                                      AppColors.kprimary,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      gender = value.toString();
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          )),
                                  userType == "2"
                                      ? Container()
                                      : SizedBox(
                                          height: 10.h,
                                        ),
                                  userType == "2"
                                      ? Container()
                                      : detailsForm(
                                          "Specialization",
                                          CustomTextFormField(
                                            hintText: "Specialization",
                                            // textInputType: TextInputType.phone,
                                            controller: settingController
                                                .specialization.value,

                                            prefix: Icon(
                                              Icons.heat_pump_rounded,
                                              color: AppColors.kprimary,
                                            ),

                                            // labelText: "Phone Number",
                                          )),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  detailsForm(
                                      "Phone Number",
                                      CustomTextFormField(
                                        hintText: "Phone Number",
                                        textInputType: TextInputType.phone,
                                        controller:
                                            settingController.editPhone.value,
                                        prefix: Icon(
                                          Icons.mobile_friendly_outlined,
                                          color: AppColors.kprimary,
                                        ),

                                        // labelText: "Phone Number",
                                      )),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  buildFieldWidget("E-mail",
                                      settingController.editEmail.value.text),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  // detailsForm(
                                  //     userType == "2"
                                  //         ? "Address"
                                  //         : "Experience",
                                  //     CustomTextFormField(
                                  //         hintText: userType == "2"
                                  //             ? "Address"
                                  //             : "Experience",
                                  //         maxLines: userType == "2" ? 2 : 1,
                                  //         controller: userType == "2"
                                  //             ? settingController.address.value
                                  //             : settingController
                                  //                 .experience.value

                                  //         // prefix: userType == "2"
                                  //         //     ? Padding(
                                  //         //       padding: const EdgeInsets.all(12.0),
                                  //         //       child: SvgPicture.asset(
                                  //         //           "assets/svg/location.svg"),
                                  //         //     )
                                  //         //     : Icon(
                                  //         //         Icons.person,
                                  //         //         color: AppColors.kprimary,
                                  //         //       ),

                                  //         // labelText: "Phone Number",
                                  //         )),
                                  // SizedBox(
                                  //   height: 10.h,
                                  // ),
                                  userType == "2"
                                      ? detailsForm(
                                          "Description",
                                          CustomTextFormField(
                                            hintText: "Description",
                                            maxLines: 4,
                                            controller: settingController
                                                .description.value,
                                          ))
                                      : Container(),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 20.h),
                                    child: settingController
                                                .rxRequestStatus.value ==
                                            Status.loading
                                        ? CustomLoading()
                                        : CustomElevatedButton(
                                            text: "Submit",
                                            onTap: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                settingController
                                                    .updateProfile();
                                              }
                                            },
                                          ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 15.h,
                        child: avatarContainer(),
                      ),
                    ],
                  );
                }),
              );
            case Status.error:
              return const Text("Error");
            default:
              return Container();
          }
        })),
      ),
    );
  }

  Padding detailsForm(name, textField) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: AppTextStyles.bodyText,
          ),
          SizedBox(height: 5.h),
          textField
        ],
      ),
    );
  }

  avatarContainer() {
    return GetBuilder<ImagePickerController>(
        init: ImagePickerController(),
        builder: (value) {
          return Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              imagePickerController.result != null
                  ? CircleAvatar(
                      radius: 60.r,
                      backgroundColor: AppColors.kprimary.withOpacity(0.1),
                      backgroundImage: FileImage(
                        imagePickerController.result!,
                      ),
                    )
                  : CircleAvatar(
                      radius: 60.r,
                      backgroundColor: AppColors.kprimary.withOpacity(0.1),
                      backgroundImage: _user['avatar'] == null
                          ? const AssetImage("assets/images/user_avatar.png")
                          : NetworkImage(ApiNetwork.imageUrl + _user['avatar'])
                              as ImageProvider,
                    ),
              Positioned(
                bottom: 8.h,
                child: InkWell(
                  onTap: () {
                    imagePickerController.pickImage();
                    // print(imagePickerController.result!);
                  },
                  child: Container(
                      height: 30.h,
                      width: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: AppColors.kprimary,
                      ),
                      alignment: Alignment.centerRight,
                      child: const Center(
                          child: Icon(
                        Icons.add_a_photo_outlined,
                        size: 18,
                        color: Colors.white,
                      ))),
                ),
              )
            ],
          );
        });
  }

  buildFieldWidget(helper, value) {
    print(helper);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            helper ?? "Registration No.",
            style: AppTextStyles.hintText,
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0.w),
            child: Text(
              value,
              style: AppTextStyles.text18Black800,
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
