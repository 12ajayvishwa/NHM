// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pvi_nhm/widgets/custom_circuler_loader.dart';
import '../../controllers/setting_controller.dart';
import '../../core/constants/api_network.dart';
import '../../core/constants/app_export.dart';
import '../../core/constants/session_manager.dart';
import '../../core/routes/app_routes.dart';
import '../../data/apiClient/http_response.dart';
import '../../theme/color_constants.dart';
import '../../theme/text_style.dart';
import '../../utils/custom_toast.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/log_out_popup_dialog.dart';
import '../../controllers/auth_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthController authController = Get.put(AuthController());
  SettingController settingController = Get.put(SettingController());
  // ignore: prefer_typing_uninitialized_variables
  var _user;
  @override
  void initState() {
    _user = json.decode(SessionManager.getUser().toString());
    toast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("userdata from session $_user");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.backGroundColor,
        appBar: CustomAppBar(
          title: "Profile",
          isLeading: true,
          centerTitle: true,
          onPressed: () {
            Get.offAllNamed(AppRoutes.DASHBOARD);
          },
        ),
        body: Obx(() {
          switch (authController.rxRequestStatus.value) {
            case Status.loading:
              return const CustomLoading();
            case Status.success:
              return Stack(
                children: [
                  Column(children: [
                    SizedBox(
                      height: 34.h,
                    ),
                    _buildProfileCard(),
                    SizedBox(
                      height: 34.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 0),
                                blurRadius: 12,
                                spreadRadius: 12,
                                color: const Color(0xFFE6E6EA).withOpacity(.8),
                              )
                            ]),
                        child: Column(
                          children: [
                            _buildTileWidget(
                              title: "Contact Support",
                              icon: "assets/icons/contact_suport.svg",
                              onTap: () {
                                Get.toNamed(AppRoutes.CONTACT_SUPPORT);
                              },
                            ),
                            _buildTileWidget(
                              title: "Term & Condition",
                              icon: "assets/icons/term&conditon.svg",
                              onTap: () {
                                Get.toNamed(AppRoutes.TERM_CONDITION);
                              },
                            ),
                            _buildTileWidget(
                              title: "FAQ",
                              icon: "assets/icons/faq.svg",
                              onTap: () {
                                Get.toNamed(AppRoutes.FAQ);
                              },
                            ),
                            _buildTileWidget(
                              title: "About",
                              icon: "assets/icons/about.svg",
                              onTap: () {},
                            ),
                            _buildTileWidget(
                              title: "Sign Out",
                              icon: "assets/icons/logout.svg",
                              onTap: () {
                                onTapLogout(context, settingController);
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ]),
                  settingController.rxRequestStatus.value == Status.loading
                      ? Container(
                          width: size.width,
                          height: size.height,
                          decoration: BoxDecoration(
                            color: AppColors.black121212.withOpacity(0.6),
                          ),
                          child: const Center(
                            child: CustomLoading(),
                          ),
                        )
                      : Container(),
                ],
              );
            case Status.error:
              return const Text("Error");
            default:
              return Container();
          }
        }));
  }

  Column _buildProfileCard() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            padding: EdgeInsets.only(
                left: 30.h, right: 30.h, top: 10.h, bottom: 10.h),
            height: 89.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.ksecondaryColor,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gray.withOpacity(0.5),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                  offset:
                      const Offset(0.0, 0.5), // shadow direction: bottom right
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 27.r,
                  backgroundColor: AppColors.whiteA700,
                  backgroundImage: _user['avatar'] == null
                      ? const AssetImage("assets/images/user_avatar.png")
                      : NetworkImage(ApiNetwork.imageUrl + _user['avatar'])
                          as ImageProvider,
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _user["name"] ?? "Name",
                      style: AppTextStyles.text14WhiteBold,
                    ),
                    Text(
                      "25, Male",
                      style: AppTextStyles.text11WhiteRegular,
                    ),
                  ],
                )),
                CustomIconButton(
                  height: 23.25.h,
                  width: 23.25.w,
                  child: CustomImageView(
                    svgPath: "assets/icons/edit.svg",
                  ),
                  onTap: () {
                    Get.toNamed(AppRoutes.EDITPROFILE);
                  },
                )
              ],
            )),
      ],
    );
  }

  Column _buildTileWidget({String? title, String? icon, VoidCallback? onTap}) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          onTap: onTap,
          tileColor: Colors.white,
          leading: Container(
            height: 45.h,
            width: 45.h,
            decoration: BoxDecoration(
              color: AppColors.blackLight.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                icon!,
                color: AppColors.blackLight,
              ),
            ),
          ),
          title: Text(
            title!,
            style: AppTextStyles.text16Black600,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 15.r,
            color: AppColors.gray,
          ),
        ),
      ],
    );
  }

  detailsFields(icon, text, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: AppColors.kprimary,
              height: 20.h,
            ),
            SizedBox(width: 12.w),
            Text(
              text,
              style: AppTextStyles.bodyText,
            )
          ],
        ),
      ),
    );
  }

  onTapLogout(context, SettingController settingController) {
    showDialog(
      context: context,
      builder: (context) {
        return LogOutPopUpDialog(
          onPressed: () {
            settingController.logout();
          },
        );
      },
    );
  }
}
