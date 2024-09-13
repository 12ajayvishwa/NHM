import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_export.dart';
import '../../theme/color_constants.dart';
import '../../theme/text_style.dart';
import '../../widgets/app_bar_container.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_pin_code_text_field.dart';
import '../../widgets/custom_text_form_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int currentPage = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        children: [
          appBarContainer(
            size,
            title: "Forgot Password",
            isLeading: true,
          ),
          Expanded(
              child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              _buildPageOneWidget(),
              _buildPageTwoWidget(),
              _buildPageThreeWidget()
            ],
          )),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: CustomElevatedButton(
                text: "Next",
                onTap: () {
                  pageController.animateToPage(pageController.page!.toInt() + 1,
                      duration: const Duration(seconds: 1), curve: Curves.ease);
                },
              )),
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }

  _buildPageTwoWidget() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100.h),
            Text(
              "Please enter the code we sent you to email",
              textAlign: TextAlign.center,
              style: AppTextStyles.text18White600.copyWith(
                  fontSize: 14.sp,
                  color: const Color(0xFFC4C4C4),
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 40.h,
            ),
            CustomPinCodeTextField(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              length: 4,
              context: context,
              onChanged: (p0) {},
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Didn’t Receive the Code ?",
              textAlign: TextAlign.center,
              style: AppTextStyles.text18White600.copyWith(
                fontSize: 12.sp,
                color: const Color(0xFFC4C4C4),
              ),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  "Resend Code",
                  style:
                      AppTextStyles.text16BlackBold.copyWith(fontSize: 14.sp),
                )),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "1 of 2",
                  style: AppTextStyles.text14WhiteBold
                      .copyWith(color: AppColors.black900),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 8.h,
              width: double.infinity,
              color: const Color(0xFFCBCBCB),
              child: Stack(
                children: [
                  Container(
                    height: 8.h,
                    width: MediaQuery.of(context).size.width / 2,
                    color: AppColors.kprimary,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildPageThreeWidget() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 70.h,
          ),
          Text(
            "Create a New Password",
            style: AppTextStyles.text20BlackRaguler
                .copyWith(fontWeight: FontWeight.w600, fontSize: 28.sp),
          ),
          SizedBox(
            height: 30.h,
          ),
          const CustomTextFormField(
            hintText: "New Password",
            labelText: "New Password",
            prefix: Icon(Icons.lock),
            obscureText: true,
          ),
          SizedBox(
            height: 20.h,
          ),
          const CustomTextFormField(
            hintText: "Confirm Password",
            labelText: "Confirm Password",
            prefix: Icon(Icons.lock),
            obscureText: true,
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "2 of 2",
                style: AppTextStyles.text14WhiteBold
                    .copyWith(color: AppColors.black900),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 8.h,
            width: double.infinity,
            color: const Color(0xFFCBCBCB),
            child: Stack(
              children: [
                Container(
                  height: 8.h,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.kprimary,
                ),
              ],
            ),
          )
        ])));
  }

  SingleChildScrollView _buildPageOneWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Forgot Password ?",
            style: AppTextStyles.appBarHeadingText.copyWith(
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black900),
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomImageView(
            svgPath: "assets/svg/forgot.svg",
            width: 241.w,
            height: 224.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
            child: Text(
              "Where would you like to receive a Verification Code ?",
              style: AppTextStyles.text15White500.copyWith(
                  fontWeight: FontWeight.w400, color: AppColors.black900),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
            ),
            height: 100.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.whiteA700,
              borderRadius: BorderRadius.circular(22.r),
              border: Border.all(color: AppColors.kprimary, width: 2.sp),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  svgPath: "assets/icons/message fill.svg",
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Via SMS"),
                    SizedBox(
                      height: 5.h,
                    ),
                    const Text("+1 123********99")
                  ],
                ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
            ),
            height: 100.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.whiteA700,
              borderRadius: BorderRadius.circular(22.r),
              border: Border.all(color: AppColors.kprimary, width: 2.sp),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  svgPath: "assets/icons/message fill.svg",
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Via SMS"),
                    SizedBox(
                      height: 5.h,
                    ),
                    const Text("+1 123********99")
                  ],
                ))
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
