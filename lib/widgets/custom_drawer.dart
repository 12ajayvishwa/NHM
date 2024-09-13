import 'package:pvi_nhm/theme/text_style.dart';
import '../core/constants/app_export.dart';
import '../theme/color_constants.dart';
import '../theme/theme_helper.dart';
import '../utils/image_constant.dart';
import 'custom_image_view.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    super.key,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool isUserManagement = false;
  bool isAdmin = false;
  bool isHR = false;
  bool isAssessment = false;
  //HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 180,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.kprimary,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          ImageConstant.logo,
                          width: 120,
                        ),
                      ),
                    ),
                     Text(
                      "Name ",
                      style: AppTextStyles.bodyText,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: DrawerListTile(
                press: () {
                  // Get.toNamed(AppRoutes.homeScreen);
                },
                svgSrc: ImageConstant.dashboardIcon,
                title: "Home",
              ),
            ),
            ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 15),
              collapsedIconColor: Colors.white,
              iconColor: Colors.white,
              title: Text("User Management",
                  style: TextStyle(fontSize: 18, color: appTheme.blueGray900)),
              trailing: Icon(
                isUserManagement
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_right,
                color: appTheme.blueGray900,
              ),
              leading: Icon(
                Icons.person,
                color: appTheme.blueGray900,
                size: 30.0,
              ),
              onExpansionChanged: (bool expanded) {
                setState(() {
                  isUserManagement = expanded;
                });
              },
              children: [
                DrawerListTile(
                  press: () {
                    // Get.toNamed(AppRoutes.userScreen);
                  },
                  svgSrc: ImageConstant.userManagement,
                  title: "Users",
                ),
                DrawerListTile(
                  press: () {
                    // Get.toNamed(AppRoutes.roleScreen);
                  },
                  svgSrc: ImageConstant.roles,
                  title: "Roles",
                ),
              ],
            ),
            ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 15),
              collapsedIconColor: Colors.white,
              iconColor: Colors.white,
              title: Text("Admin",
                  style: TextStyle(fontSize: 18, color: appTheme.blueGray900)),
              trailing: Icon(
                isAdmin
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_right,
                color: appTheme.blueGray900,
              ),
              leading: Icon(
                Icons.admin_panel_settings,
                color: appTheme.blueGray900,
                size: 30.0,
              ),
              onExpansionChanged: (bool expanded) {
                setState(() {
                  isAdmin = expanded;
                });
              },
              children: [
                DrawerListTile(
                  press: () {
                    // Get.toNamed(AppRoutes.manpowerScreen);
                  },
                  svgSrc: ImageConstant.manpower,
                  title: "Manpower",
                ),
                DrawerListTile(
                  press: () {
                    // Get.toNamed(AppRoutes.departmentsScreen);
                  },
                  svgSrc: ImageConstant.departments,
                  title: "Departments",
                ),
              ],
            ),
            ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 15),
              collapsedIconColor: Colors.white,
              iconColor: Colors.white,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("H-R",
                        style: TextStyle(
                            fontSize: 18, color: appTheme.blueGray900)),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: Colors.red,
                    //       borderRadius: BorderRadius.circular(5)),
                    //   padding: const EdgeInsets.all(5.0),
                    //   child: const Text("New",
                    //       style: TextStyle(
                    //         fontSize: 15,
                    //         color: Colors.white,
                    //       )),
                    // ),
                  ]),
              trailing: Icon(
                isHR ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                color: appTheme.blueGray900,
              ),
              leading: Icon(
                Icons.dvr,
                color: appTheme.blueGray900,
                size: 30.0,
              ),
              onExpansionChanged: (bool expanded) {
                setState(() {
                  isHR = expanded;
                });
              },
              children: [
                DrawerListTile(
                  press: () {
                    // Get.toNamed(AppRoutes.disciplineScreen);
                  },
                  svgSrc: ImageConstant.discipline,
                  title: "Discipline",
                ),
                DrawerListTile(
                  press: () {
                    // Get.toNamed(AppRoutes.attendanceScreen);
                  },
                  svgSrc: ImageConstant.attendence,
                  title: "Attendence",
                ),
                DrawerListTile(
                  press: () {
                    // Get.toNamed(AppRoutes.interviewScreen);
                  },
                  svgSrc: ImageConstant.interview,
                  title: "Interview",
                ),
                // DrawerListTile(
                //   press: () {
                // Get.toNamed(AppRoutes.notesScreen);
                //   },
                //   svgSrc: ImageConstant.notes,
                //   title: "Notes Descipline",
                // ),
                DrawerListTile(
                  press: () {
                    // Get.toNamed(AppRoutes.salaryManagementScreen);
                  },
                  svgSrc: ImageConstant.salary,
                  title: "Salary Management",
                ),
                // DrawerListTile(
                //   press: () {
                //     Get.toNamed(AppRoutes.totalHiring);
                //   },
                //   svgSrc: ImageConstant.hiring,
                //   title: "Total Hiring",
                // ),
                DrawerListTile(
                  press: () {
                    // Get.toNamed(AppRoutes.leaveScreen);
                  },
                  svgSrc: ImageConstant.leave,
                  title: "Leave",
                ),
                DrawerListTile(
                  press: () {
                    // Get.toNamed(AppRoutes.holidayScreen);
                  },
                  svgSrc: ImageConstant.hiring,
                  title: "Holiday",
                ),
                DrawerListTile(
                  press: () {
                    // Get.toNamed(AppRoutes.eventCalander);
                  },
                  svgSrc: ImageConstant.eventCalander,
                  title: "Events Calendar",
                ),
              ],
            ),
            ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 15),
              collapsedIconColor: Colors.white,
              iconColor: Colors.white,
              title: Text("Assessment",
                  style: TextStyle(fontSize: 18, color: appTheme.blueGray900)),
              trailing: Icon(
                isAssessment
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_right,
                color: appTheme.blueGray900,
              ),
              leading: Icon(
                Icons.assessment,
                color: appTheme.blueGray900,
                size: 30.0,
              ),
              onExpansionChanged: (bool expanded) {
                setState(() {
                  isAssessment = expanded;
                });
              },
              children: [
                DrawerListTile(
                  press: () {
                    // Get.toNamed(AppRoutes.taskScreen);
                  },
                  svgSrc: ImageConstant.taskIcon,
                  title: "Task",
                ),
                // DrawerListTile(
                //   press: () {
                //     Get.toNamed(AppRoutes.companyPolicies);
                //   },
                //   svgSrc: ImageConstant.companyPolicy,
                //   title: "Company Policies",
                // ),
                DrawerListTile(
                  press: () {
                    // Get.toNamed(AppRoutes.boardList);
                  },
                  svgSrc: ImageConstant.board,
                  title: "Board",
                ),
                DrawerListTile(
                  press: () {
                    // Get.toNamed(AppRoutes.birthdayCards);
                  },
                  svgSrc: ImageConstant.birthdayCard,
                  title: "Birthday Cards",
                ),
              ],
            ),
            DrawerListTile(
              press: () {
                // Get.toNamed(AppRoutes.eventCalander);
              },
              svgSrc: ImageConstant.eventCalander,
              title: "Events Calendar",
            ),
            DrawerListTile(
              press: () {
                // Get.toNamed(AppRoutes.projectListScreen);
              },
              svgSrc: ImageConstant.projects,
              title: "Project",
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String title, svgSrc;
  final VoidCallback press;
  const DrawerListTile({
    super.key,
    required this.title,
    required this.press,
    required this.svgSrc,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      splashColor: appTheme.amber800,
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: CustomImageView(
        svgPath: svgSrc,
        height: 25,
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Text(title,
            style: TextStyle(color: appTheme.blueGray900, fontSize: 18)),
      ),
    );
  }
}
