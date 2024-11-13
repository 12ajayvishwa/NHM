import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/patient_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../core/constants/app_export.dart';
import '../../../data/apiClient/http_response.dart';
import '../../../theme/color_constants.dart';
import '../../../utils/calender_theme.dart';
import '../../../widgets/app_bar_container.dart';
import '../../../widgets/custom_circuler_loader.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_form_field.dart';

enum Verify { yes, no }

class ReassignSurgery extends StatefulWidget {
  ReassignSurgery({super.key});

  @override
  State<ReassignSurgery> createState() => _ReassignSurgeryState();
}

class _ReassignSurgeryState extends State<ReassignSurgery> {
  PatientController patientController = Get.put(PatientController());
  UserController userController = Get.put(UserController());

  AuthController authController = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();

  Verify verify = Verify.yes;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userController.clearData();
    userController.getUserList();
    patientController.getPatient();
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
                    title: "Reassign Surgery",
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
        return CustomLoading();
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
                hintText: "Surgery title",
                labelText: "Surgery title",
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
                    }
                  }
                },
              ),
              CustomDropdown(
                // prefix: CustomImageView(
                //   svgPath: "assets/icons/hospital.svg",
                // ),

                labelText: "Patient",
                validator: (p0) {
                  if (p0 == null) {
                    return "Patient is required.";
                  }
                  return null;
                },

                listName: patientController.patientList
                    .map((e) => e.patientName)
                    .toList(),
                hintText: "Select Paatient",

                onChng: (data) {
                  for (var i in patientController.patientList) {
                    if (i.patientName == data) {
                      userController.patientlId = i.id.toString();
                    }
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
                    }
                  }
                },
              ),
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
                  return null;
                },
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(
                hintText: "Desctiption",
                labelText: "Desctiption",
                controller: patientController.descriptionController,
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
                    return "Please enter description";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.h),
              patientController.rxRequestStatus.value == Status.loading
                  ? const CustomLoading()
                  : CustomElevatedButton(
                      text: "Submit",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          patientController.reAssignSurgery(
                             );
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
