// ignore_for_file: constant_identifier_names
import 'package:pvi_nhm/notification/notification_screen.dart';
import 'package:pvi_nhm/presentation/dashboard/reasign_surgery/assigned_screen.dart';
import 'package:pvi_nhm/presentation/dashboard/users/add_user.dart';
import 'package:pvi_nhm/presentation/dashboard/widget/patient_detail_screen.dart';
import 'package:pvi_nhm/presentation/dashboard/widget/profile_detail_screen.dart';
import '../../presentation/auth/binding/auth_binding.dart';
import '../../presentation/auth/login_screen.dart';
import '../../presentation/auth/login_verification/binding/login_verification_binding.dart';
import '../../presentation/auth/login_verification/login_verification_screen.dart';
import '../../presentation/auth/signup_screen.dart';
import '../../presentation/dashboard/category_pages/all_doctor.dart';
import '../../presentation/dashboard/category_pages/all_patient.dart';
import '../../presentation/dashboard/category_pages/completed_patient_screen.dart';
import '../../presentation/dashboard/category_pages/done.dart';
import '../../presentation/dashboard/category_pages/pending_patient_screen.dart';
import '../../presentation/dashboard/category_pages/supervisor.dart';
import '../../presentation/dashboard/dashboard.dart';
import '../../presentation/dashboard/patient/add_patient.dart';
import '../../presentation/dashboard/reasign_surgery/add_surgery.dart';
import '../../presentation/dashboard/widget/surgery_details.dart';
import '../../presentation/onboard/onboard.dart';
import '../../presentation/profile/edit_profile.dart';
import '../../presentation/profile/profile_screen.dart';
import '../../presentation/profile/screen/FAQ/faq_screen.dart';
import '../../presentation/profile/screen/contact_support/contact_support_screen.dart';
import '../../presentation/profile/screen/term&condition/term_condition_screen.dart';
import '../../presentation/splash/ui/splash_screen.dart';
import '../constants/app_export.dart';

class AppRoutes {
  // App Starting Routes
  static const SPLASHSCREEN = '/';
  static const ONBOARDSCREEN = '/onboard';

  //Auth Routes
  static const LOGIN = '/login';
  static const LOGIN_VERIFICATION = '/login_verification';
  static const SIGN_UP = '/sign_up';
  static const PROFILE = '/profile';
  static const EDITPROFILE = '/edit_profile';
  static const FORGOT_PASSWORD = '/forgot_password';

  //Common Routes
  static const NOTIFICATION = '/notification';
  static const CONTACT_SUPPORT = '/contact_support';
  static const TERM_CONDITION = '/term_condition';
  static const FAQ = '/faq';
  static const DASHBOARD = "/dashboard";
  static const PROFILEDETAL = "/profile_details";
  static const PATIENTDETIAL = "/patient_details";
  static const ALL_PATIENT = "/all_patient";
  static const COMPLETE_PATIENT = "/complete_patient";
  static const PANDING_PATIENT = "/panding_patient";
  static const All_DOC = "/all_doc";
  static const ALL_SUP = "/sup";
  static const ALL_DONE = "/done";

  // Super Admin Routes
  static const ADD_PATIENT = "/add_patient";
  static const ADD_USER = "/add_user";
  static const DOCTOR_PROFILE = "/doctor_profile";
  static const Reassign_Surgery = "/reassign_surgery";
  static const Assigned_Surgery = "/assigned_surgery";
  static const Assigned_Surgery_Details = "/assigned_surgery_details";
  static const Assigned_Surgery_List = "/assigned_surgery_list";
  

  static List<GetPage> pages = [
    GetPage(
      binding: AuthBinding(),
      name: LOGIN,
      page: () => const LoginScreen(),
    ),
    GetPage(name: SPLASHSCREEN, page: () => const SplashScreen()),
    GetPage(name: ONBOARDSCREEN, page: () => const OnBoardingScreen()),
    GetPage(
        binding: AuthBinding(), name: LOGIN, page: () => const LoginScreen()),
    GetPage(
        binding: LoginVerificationBinding(),
        name: LOGIN_VERIFICATION,
        page: () => const LoginVerificationScreen()),
    GetPage(
      name: SIGN_UP,
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: EDITPROFILE,
      page: () => const EditProfile(),
    ),
    GetPage(
      name: NOTIFICATION,
      page: () => const NotificationScreen(),
    ),
    GetPage(name: PROFILE, page: () => const ProfileScreen()),
    GetPage(name: CONTACT_SUPPORT, page: () => ContactSupportScreen()),
    GetPage(name: TERM_CONDITION, page: () => const TermConditionScreen()),
    GetPage(name: FAQ, page: () => const FAQScreen()),
    GetPage(name: DASHBOARD, page: () => const Dashboard()),
    GetPage(name: ADD_PATIENT, page: () => AddPatientScreen()),
    GetPage(name: ADD_USER, page: () => AddUserScreen()),
    GetPage(name: PROFILEDETAL, page: () => const ProfileDetailScreen()),
    GetPage(name: PATIENTDETIAL, page: () => const PatientDetailScreen()),
    GetPage(name: ADD_PATIENT, page: () => const AllPatientScreen()),
    GetPage(name: COMPLETE_PATIENT, page: () => const CompletedPatientScreen()),
    GetPage(name: PANDING_PATIENT, page: () => const PandingPatientScreen()),
    GetPage(name: All_DOC, page: () => const AllDoctorScreen()),
    GetPage(name: ALL_SUP, page: () => const AllSupervisorScreen()),
    GetPage(name: ALL_PATIENT, page: () => const AllPatientScreen()),
    GetPage(name: ALL_DONE, page: () => const DoneScreen()),
    GetPage(name: Reassign_Surgery, page: () =>  ReassignSurgery()),
    GetPage(name: Assigned_Surgery, page: () => const AssignedSurgeryScreen()),
    GetPage(name: Assigned_Surgery_Details, page: () => const SurgeryDetailScreen()),

  ];
}
