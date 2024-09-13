import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/session_manager.dart';
import '../../theme/color_constants.dart';
import '../../utils/custom_toast.dart';
import '../../widgets/custom_image_view.dart';
import 'home/home.dart';
import 'patient/patient_screen.dart';
import 'reasign_surgery/assigned_screen.dart';
import 'users/add_user.dart';
import 'users/users_screen.dart';

var tabIndexOfApn;

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var data = Get.arguments;

  int? _selectedIndex = 0;

  static const List<Widget> _dotor = <Widget>[
    // AppointmentScreen(),
    // HomeScreen(),
    // AllReocrdsScreen()
  ];
  // static const List<Widget> _admin = <Widget>[
  //   AppointmentScreen(),
  //   HomeScreen(),
  //   DoctorDprScreen(),
  // ];
  static final List<Widget> _approval = <Widget>[
    const HomeScreen(),
    PatientScreen(),
    // Text("data"),
    UsersScreen(),
   

    // const AddRequestScreen(),
    // const AllRequestScreen(),
    // DoctorsHospitalScreen(),
    // const AllReocrdsScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    toast.init(context);
    if (data != null) {
      _selectedIndex = data[0];
    }
    tabIndexOfApn = SessionManager.getUserTypeId() == "3"
        ? data == null
            ? null
            : data[1]
        : SessionManager.getUserTypeId() == "2"
            ? data == null
                ? null
                : data[1]
            : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("dfddd ${data == null ? null : data[0]}");
    }
    return Scaffold(
      body: Center(
        child: _approval.elementAt(_selectedIndex ?? 0),
      ),
      bottomNavigationBar: customNavigationBar(),
    );
  }

  BottomNavigationBar customNavigationBar() {
    return BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          for (var i = 0; i < bottomNavItemList.length; i++)
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _selectedIndex == i
                      ? AppColors.kprimary
                      : Colors.transparent,
                ),
                child: CustomImageView(
                  svgPath: bottomNavItemList[i]["icon"],
                  color: _selectedIndex == i ? AppColors.whiteA700 : AppColors.gray,
                ),
              ),
              label: bottomNavItemList[i]["label"],
            ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex ?? 1,
        selectedItemColor: AppColors.ksecondaryColor,
        unselectedItemColor: AppColors.ksecondaryColor.withOpacity(0.8),
        onTap: _onItemTapped,
        elevation: 8);
  }

  List<dynamic> bottomNavItemList = SessionManager.getUserTypeId() == "2" ||
          SessionManager.getUserTypeId() == "3"
      ? [
          {
            "icon": "assets/icons/home.svg",
            "label": "Home",
          },
          {
            "icon": "assets/svg/guidance--in-patient.svg",
            "label": "Patient",
          },
        ]
      : [
          {
            "icon": "assets/icons/home.svg",
            "label": "Home",
          },
          {
            "icon": "assets/svg/add.svg",
            "label": "Add Request",
          },
          {
            "icon": "assets/svg/doctor_icon.svg",
            "label": "Doctor",
          },
          // {
          //   "icon": "assets/svg/ic--round-add-task.svg",
          //   "label": "add new",
          // }
        ];
}
