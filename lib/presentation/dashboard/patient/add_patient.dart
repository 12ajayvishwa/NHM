import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pvi_nhm/controllers/user_controller.dart';
import '../../../../core/constants/app_export.dart';
import '../../../../widgets/image_picker.dart';
import '../../../controllers/patient_controller.dart';
import '../../../data/apiClient/http_response.dart';
import '../../../theme/color_constants.dart';
import '../../../theme/text_style.dart';
import '../../../utils/calender_theme.dart';
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

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  PatientController patientController = Get.put(PatientController());
  UserController userController = Get.put(UserController());

  AuthController authController = Get.put(AuthController());

  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());

  final _formKey = GlobalKey<FormState>();
  Gender gender = Gender.male;
  Verify verify = Verify.yes;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    userController.clearData();
    userController.getUserList();
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
                    title: "Add Patient",
                    isLeading: true,
                  ),
                ),
                Positioned(
                  bottom: -40.h,
                  right: -15.w,
                  child: SvgPicture.asset("assets/svg/Rectangle 5904.svg"),
                ),
                Positioned(
                    top: 150.h,
                    right: 15.w,
                    left: 15.w,
                    bottom: 15.h,
                    child: addPatientForm(size)),
              ],
            ))
          ]),
        ),
      ),
    );
  }

  addPatientForm(size) {
    return Obx(() {
      if (userController.rxRequestStatus.value == Status.loading) {
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
            children: [
              CustomTextFormField(
                hintText: "Patient Name",
                labelText: "Patient Name",
                // prefix: Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: SvgPicture.asset("assets/icons/person.svg"),
                // ),
                controller: patientController.nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter patient name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.h),
              CustomTextFormField(
                hintText: "S/O , W/O",
                labelText: "S/O , W/O",
                // prefix: Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: SvgPicture.asset("assets/icons/person.svg"),
                // ),
                controller: patientController.name1Controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter name";
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
              CustomTextFormField(
                  labelText: "Phone number",
                  hintText: "Phone number",
                  controller: patientController.phoneController,
                  maxLength: 10,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  //  prefix: Icon(Icons.phone, color: AppColors.gray),
                  textInputType: TextInputType.number,
                  validator: phoneNumberValidator),
              SizedBox(height: 10.h),
              CustomTextFormField(
                hintText: "Age",
                labelText: "Age",
                // prefix: Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: SvgPicture.asset("assets/icons/person.svg"),
                // ),
                controller: patientController.ageController,
                maxLength: 3,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter age";
                  } else {
                    final intAge = int.tryParse(value);
                    if (intAge == null) {
                      return "Please enter a valid number";
                    } else if (intAge > 100) {
                      return "Age should be less than or equal to 100";
                    }
                  }
                  return null; // Return null if the value is valid
                },
              ),
              SizedBox(height: 10.h),
              Row(children: [
                SizedBox(
                  width: 190.w,
                  child: CustomTextFormField(
                    hintText: "Village",
                    labelText: "Village",
                    controller: patientController.villageController,
                    // prefix: Padding(
                    //   padding: const EdgeInsets.all(12.0),
                    //   child: SvgPicture.asset("assets/icons/email.svg"),
                    // ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter village name";
                      }
                    },
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 180.w,
                  child: CustomTextFormField(
                    hintText: "Block",
                    labelText: "Block",
                    controller: patientController.blockController,
                    // prefix: Padding(
                    //   padding: const EdgeInsets.all(12.0),
                    //   child: SvgPicture.asset("assets/icons/email.svg"),
                    // ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter block name";
                      }
                    },
                  ),
                ),
              ]),
              SizedBox(height: 10.h),
              Row(children: [
                SizedBox(
                  width: 190.w,
                  child: CustomTextFormField(
                    hintText: "District",
                    labelText: "District",
                    controller: patientController.districtController,
                    // prefix: Padding(
                    //   padding: const EdgeInsets.all(12.0),
                    //   child: SvgPicture.asset("assets/icons/email.svg"),
                    // ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter district";
                      }
                    },
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 180.w,
                  child: CustomTextFormField(
                    hintText: "Mp ID",
                    labelText: "Mp ID",
                    controller: patientController.mpidController,
                    // prefix: Padding(
                    //   padding: const EdgeInsets.all(12.0),
                    //   child: SvgPicture.asset("assets/icons/email.svg"),
                    // ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter mpid";
                      }
                    },
                  ),
                ),
              ]),
              SizedBox(height: 10.h),
              Row(children: [
                SizedBox(
                  width: 190.w,
                  child: CustomTextFormField(
                    hintText: "Gravida",
                    labelText: "Gravida",
                    controller: patientController.gravidaController,
                    // prefix: Padding(
                    //   padding: const EdgeInsets.all(12.0),
                    //   child: SvgPicture.asset("assets/icons/email.svg"),
                    // ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter gravida";
                      }
                    },
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 180.w,
                  child: CustomTextFormField(
                    hintText: "parity",
                    labelText: "parity",
                    controller: patientController.parityController,
                    // prefix: Padding(
                    //   padding: const EdgeInsets.all(12.0),
                    //   child: SvgPicture.asset("assets/icons/email.svg"),
                    // ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter parity";
                      }
                    },
                  ),
                ),
              ]),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                hintText: "Procedure",
                labelText: "Procedure",
                controller: patientController.procedureController,
                // prefix: Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: SvgPicture.asset("assets/icons/email.svg"),
                // ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter procedure";
                  }
                },
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                hintText: "Elective Surgery",
                labelText: "Elective Surgery",
                controller: patientController.electiveSurgeryController,
                // prefix: Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: SvgPicture.asset("assets/icons/email.svg"),
                // ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter elective surgery";
                  }
                },
              ),
              SizedBox(height: 10.h),

              CustomDropdown(
                // prefix: CustomImageView(
                //   svgPath: "assets/icons/hospital.svg",
                // ),
                
                labelText: "Anesthetist",
                validator: (p0) {
                  if (p0 == null) {
                    return "Anesthetist is required.";
                  }
                  return null;
                },
         
                listName:
                    userController.doctorList.map((e) => e.name!).toList(),
                hintText: "Select Anesthetist",

                onChng: (data) {
                  patientController.palaceOfPostingController.text = "";
                  for (var i in userController.doctorList) {
                    if (i.name == data) {
                      userController.doctorId = i.id.toString();
                      patientController.nameOfAnesthetistController.text =
                          i.name.toString();
                      patientController.typeOfAnesthetistController.text =
                          i.name.toString();
                      patientController.palaceOfPostingController.text =
                          i.address.toString();
                    }
                  }
                },
              ),
              // CustomTextFormField(
              //   hintText: "Name Of Anesthetist",
              //   labelText: "Name Of Anesthetist",
              //   controller: patientController.nameOfAnesthetistController,
              //   // prefix: Padding(
              //   //   padding: const EdgeInsets.all(12.0),
              //   //   child: SvgPicture.asset("assets/icons/email.svg"),
              //   // ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return "Please enter name of anesthetist";
              //     }
              //   },
              // ),
              // SizedBox(height: 10.h),
              // CustomTextFormField(
              //   hintText: "Type Of Anesthesia",
              //   labelText: "Type Of Anesthesia",
              //   controller: patientController.typeOfAnesthetistController,
              //   // prefix: Padding(
              //   //   padding: const EdgeInsets.all(12.0),
              //   //   child: SvgPicture.asset("assets/icons/edit_user.svg"),
              //   // ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return "Please enter type of anesthesia";
              //     }
              //   },
              // ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                hintText: "Palace Of Posting",
                labelText: "Palace Of Posting",
                controller: patientController.palaceOfPostingController,
                readOnly: true,
                // inputFormatters: [
                //   FilteringTextInputFormatter.digitsOnly,
                // ],
                // prefix: Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: SvgPicture.asset("assets/icons/edit_user.svg"),
                // ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter palace of posting";
                  }
                },
              ),
              SizedBox(height: 10.h),

              CustomDropdown(
                // prefix: CustomImageView(
                //   svgPath: "assets/icons/hospital.svg",
                // ),
                labelText: "Name Of Facility",
                validator: (p0) {
                  if (p0 == null) {
                    return "Name Of Facility is required.";
                  }
                  return null;
                },
                listName:
                    userController.approvalList.map((e) => e.name!).toList(),
                hintText: "Select Facility",

                onChng: (data) {
                  for (var i in userController.approvalList) {
                    if (i.name == data) {
                      userController.approvalId = i.id.toString();
                      patientController.nameOfFacilityController.text =
                          i.name.toString();
                    }
                  }
                },
              ),
              // CustomTextFormField(
              //   hintText: "Name Of Facility",
              //   labelText: "Name Of Facility",
              //   controller: patientController.nameOfFacilityController,
              //   // inputFormatters: [
              //   //   FilteringTextInputFormatter.digitsOnly,
              //   // ],
              //   // prefix: Padding(
              //   //   padding: const EdgeInsets.all(12.0),
              //   //   child: SvgPicture.asset("assets/icons/edit_user.svg"),
              //   // ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return "Please enter name of facility";
              //     }
              //   },
              // ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                hintText: "Date",
                labelText: "Date",
                controller: patientController.dateTimeController,
                onChanged: (p0) {
                  patientController.dateTimeController.text = p0;
                },
                readOnly: true,
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      return calenderTheme(child, context);
                    },
                  );
                  if (selectedDate != null) {
                    String formattedDate =
                        DateFormat('dd/MM/yyyy').format(selectedDate);
                    String sendFormattedDate =
                        DateFormat('yyyy-MM-dd').format(selectedDate);
                    patientController.dateTimeController.text = formattedDate;
                    patientController.date = sendFormattedDate;
                    // surgeryDate[index].text = formattedDate;
                    // handleChange(index, 'surgery_date', sendFormattedDate);
                  }
                },
                // inputFormatters: [
                //   FilteringTextInputFormatter.digitsOnly,
                // ],
                // prefix: Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: SvgPicture.asset("assets/icons/edit_user.svg"),
                // ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter date";
                  }
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
                          "Verified",
                          style: AppTextStyles.textFieldLabel,
                        ),
                        SizedBox(width: 4.w),
                        CustomImageView(
                          svgPath: "assets/icons/verify.svg",
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          activeColor: AppColors.kprimary,
                          value: Verify.yes,
                          groupValue: verify,
                          onChanged: (value) {
                            setState(() {
                              verify = value!;
                            });
                          },
                        ),
                        Text(
                          "Yes",
                          style: AppTextStyles.text12WhiteRegular.copyWith(
                              color: const Color(0xff121212),
                              fontWeight: FontWeight.w400),
                        ),
                        const Spacer(),
                        Radio(
                          activeColor: AppColors.kprimary,
                          value: Verify.no,
                          groupValue: verify,
                          onChanged: (value) {
                            setState(() {
                              verify = value!;
                            });
                          },
                        ),
                        Text(
                          "No",
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
              CustomTextFormField(
                hintText: "Address",
                labelText: "Address",
                controller: patientController.addressTimeController,
                // inputFormatters: [
                //   FilteringTextInputFormatter.digitsOnly,
                // ],
                // prefix: Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: SvgPicture.asset("assets/icons/edit_user.svg"),
                // ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter address";
                  }
                },
              ),
              SizedBox(height: 10.h),
              patientController.rxRequestStatus.value == Status.loading
                  ? const CustomLoading()
                  : CustomElevatedButton(
                      text: "Submit",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          patientController.addPatient(
                              verify.name, gender.name);
                        }
                      },
                    )
            ],
          ),
        ),
      );
    });
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
                      backgroundImage:
                          const AssetImage("assets/images/dummy_image.png")),
              // Positioned(
              //   bottom: 8.h,
              //   child: InkWell(
              //     onTap: () {
              //       imagePickerController.pickImage();
              //       // print(imagePickerController.result!);
              //     },
              //     child: Container(
              //         height: 30.h,
              //         width: 30.h,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(30.r),
              //           color: AppColors.kprimary,
              //         ),
              //         alignment: Alignment.centerRight,
              //         child: const Center(
              //             child: Icon(
              //           Icons.add_a_photo_outlined,
              //           size: 18,
              //           color: Colors.white,
              //         ))),
              //   ),
              // )
            ],
          );
        });
  }
}
