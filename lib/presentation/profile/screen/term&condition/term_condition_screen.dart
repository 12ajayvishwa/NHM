import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../theme/color_constants.dart';
import '../../../../theme/text_style.dart';
import '../../../../widgets/app_bar/custom_app_bar.dart';

class TermConditionScreen extends StatelessWidget {
  const TermConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(                                           
      backgroundColor: AppColors.whiteA700,
      appBar: CustomAppBar(
        title: "Term & Condition",
        isLeading: true,
        centerTitle: true,
        onPressed: () {
          Get.back();
        },
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                "1. Clause 1",
                style: AppTextStyles.text20BlackBold,
              ),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra condimentum eget purus in. Consectetur eget id morbi amet amet, in. Ipsum viverra pretium tellus neque. Ullamcorper suspendisse aenean leo pharetra in sit semper et. Amet quam placerat sem.",
                style: AppTextStyles.text16BlackRaguler,
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "1. Clause 2",
                style: AppTextStyles.text20BlackBold,
              ),
              Text(
                """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra condimentum eget purus in. Consectetur eget id morbi amet amet, in. Ipsum viverra pretium tellus neque. Ullamcorper suspendisse aenean leo pharetra in sit semper et. Amet quam placerat sem.
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra condimentum eget purus in. Consectetur eget id morbi amet amet, in. Ipsum viverra pretium tellus neque. Ullamcorper suspendisse aenean leo pharetra in sit semper et. Amet quam placerat sem.""",
                style: AppTextStyles.text16BlackRaguler,
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
