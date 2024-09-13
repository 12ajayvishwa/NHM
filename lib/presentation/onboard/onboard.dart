import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/constants/app_export.dart';
import '../../core/routes/app_routes.dart';
import '../../theme/color_constants.dart';
import '../../theme/text_style.dart';
import '../../widgets/custom_elevated_button.dart';

class OnBoard {
  final String image, title, description;

  OnBoard({
    required this.image,
    required this.title,
    required this.description,
  });
}

// OnBoarding content list
final List<OnBoard> demoData = [
  OnBoard(
    image: "assets/images/onboard1.svg",
    title: "Best Doctors",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  ),
  OnBoard(
    image: "assets/images/onboard2.svg",
    title: "Care You Can Trust",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  ),
  OnBoard(
    image: "assets/images/onboard3.svg",
    title: "Confortable Care",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
  ),
];

// OnBoardingScreen
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // Variables
  late PageController _pageController;
  int _pageIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Initialize page controller
    _pageController = PageController(initialPage: 0);
    // Automatic scroll behaviour
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageIndex < 3) {
        _pageIndex++;
      } else {
        _pageIndex = 0;
      }

      _pageController.animateToPage(
        _pageIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    // Dispose everything
    _pageController.dispose();
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          // Background gradient

          child: Column(
            children: [
              // Carousel area
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemCount: demoData.length,
                  controller: _pageController,
                  itemBuilder: (context, index) => OnBoardContent(
                    title: demoData[index].title,
                    description: demoData[index].description,
                    image: demoData[index].image,
                  ),
                ),
              ),
              // Indicator area
              Padding(
                padding: EdgeInsets.only(bottom: 16.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      demoData.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: DotIndicator(
                          isActive: index == _pageIndex,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Privacy policy area
              const Text(
                "By proceeding you agree to our Privacy Policy",
                style: AppTextStyles.smallText,
              ),
              // White space
              SizedBox(
                height: 16.h,
              ),
              // Button area
              Container(
                margin: EdgeInsets.only(bottom: 48.w),
                child: CustomElevatedButton(
                  text: "Get Started !",
                  onTap: () {
                    Get.toNamed(AppRoutes.LOGIN);
                  },
                ),
              )
              // InkWell(
              //   onTap: () {
              //     Get.toNamed(AppRoutes.LOGIN);
              //   },
              //   child: Container(
              //     margin: const EdgeInsets.only(bottom: 48),
              //     height: Get.height * 0.075,
              //     width: Get.width,
              //     decoration: BoxDecoration(
              //       color: Colors.purple,
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: const Center(
              //       child: Text(
              //         "Login / Registration",
              //         style: TextStyle(
              //           fontFamily: "HappyMonkey",
              //           color: Colors.white,
              //           fontSize: 18,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// OnBoarding area widget
// ignore: must_be_immutable
class OnBoardContent extends StatelessWidget {
  OnBoardContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  String image;
  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SvgPicture.asset(
          image,
          height: 220.h,
        ),
        const Spacer(),
        Text(title,
            style: AppTextStyles.title2.copyWith(fontWeight: FontWeight.bold)),
        SizedBox(
          height: 16.h,
        ),
        Text(description,
            textAlign: TextAlign.center, style: AppTextStyles.smallText),
        const Spacer(),
      ],
    );
  }
}

// Dot indicator widget
class DotIndicator extends StatelessWidget {
  const DotIndicator({
    this.isActive = false,
    super.key,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8.h,
      width: isActive ? 24.w : 8.w,
      decoration: BoxDecoration(
        color: isActive ? AppColors.kprimary : Colors.white,
        border: isActive ? null : Border.all(color: AppColors.kprimary),
        borderRadius: BorderRadius.all(
          Radius.circular(12.r),
        ),
      ),
    );
  }
}
