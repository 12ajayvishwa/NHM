import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_export.dart';
import '../../../../theme/color_constants.dart';
import '../../../../theme/text_style.dart';
import '../../../../widgets/app_bar/custom_app_bar.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteA700,
      appBar: CustomAppBar(
        title: "FAQ",
        isLeading: true,
        centerTitle: true,
        onPressed: () {
          Get.back();
        },
      ),
      body: SizedBox(
        height: double.infinity,

        width: double.infinity,
        //  padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Stack(
          //   crossAxisAlignment: CrossAxisAlignment.center,

          alignment: Alignment.center,
          children: [
            Positioned(
                bottom: -30,
                right: -20,
                child: Image.asset("assets/images/design_rec.png")),
            SizedBox(
              height: 20.h,
            ),
            Positioned(
              top: 10.h,
              child: Text(
                "Help Desk",
                style: AppTextStyles.text20BlackRaguler.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Positioned(
              top: 60.h,
              left: 10.w,
              right: 10.w,
              child: Text(
                """We’re here to help you with anything and everyting on Lorem ipsum dolor""",
                style: AppTextStyles.text16BlackRaguler
                    .copyWith(fontSize: 25.sp, color: Colors.black),
              ),
            ),
            Positioned(
              top: 200.h,
              right: 10.w,
              left: 10.w,
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Viverra condimentum eget purus in. Consectetur eget id morbi amet amet",
                style: AppTextStyles.text16BlackRaguler,
              ),
            ),
            Positioned(
              top: 290.h,
              left: 10.w,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "FAQ",
                  style: AppTextStyles.text16BlackBold,
                ),
              ),
            ),
            Positioned(
              top: 320.h,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 500.h,
                width: 300,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        trailing: const Icon(Icons.add),
                        title: const Text('What is Lorem ipsum dolor?'),
                        children: <Widget>[
                          ListTile(
                            title: const Text('Item 1'),
                            onTap: () {
                              // Do something when item 1 is tapped
                            },
                          ),
                        ],
                      );
                    }),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 20.h,
              child: Container(
                height: 160.h,
                width: 280.w,
                decoration: BoxDecoration(
                    color: AppColors.ksecondaryColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25.r),
                        bottomRight: Radius.circular(25.r))),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10.h,
                      left: 10.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Any quesytion or remarks?",
                            style: AppTextStyles.smallText
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "Just contact us:",
                            style: AppTextStyles.smallText
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          contactDetails(
                            true,
                            Icons.phone_in_talk,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          contactDetails(
                              false,
                              Icons.watch,
                              Text(
                                "11:00 am - 4:00 pm",
                                style: AppTextStyles.smallText
                                    .copyWith(color: Colors.white),
                              ))
                        ],
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row contactDetails([isColumn, icon, text]) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        SizedBox(
          width: 10.w,
        ),
        isColumn == true
            ? Column(
                children: [
                  Text(
                    "+1012 3456 789",
                    style:
                        AppTextStyles.smallText.copyWith(color: Colors.white),
                  ),
                  Text(
                    "+1012 3456 789",
                    style:
                        AppTextStyles.smallText.copyWith(color: Colors.white),
                  ),
                ],
              )
            : text
      ],
    );
  }
}
