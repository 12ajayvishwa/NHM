class ApiNetwork {
// BASE URL
  static const String domain = "https://demo7.nrt.co.in";
  static const String baseUrl = "$domain/api/";
  static const String imageUrl = "$domain";
  static const String fileDownloadUrl = "$domain/api/";

  // static const String domain = "192.168.1.46:3333";
  // static const String baseUrl = "http://$domain/api/";
  // static const String imageUrl = "http://$domain/";
  // static const String fileDownloadUrl = "http://$domain/api/";

  // LOGIN
  static const String login = "${baseUrl}login";
  static const String signUp = "${baseUrl}signup";
  static const String loginVerify = "${baseUrl}login/verify";
  static const String forgotPassword = "${baseUrl}login/forgot-password";
  static const String chanhePassword = "${baseUrl}change-password";
  static const String users = "${baseUrl}users";
  static const String deleteUsers = "${baseUrl}user/delete/";
  static const String updateUsers = "${baseUrl}user/update";
  static const String logout = "${baseUrl}logout";
  static const String updateProfile = "${baseUrl}update-profile";
  static const String settings = "${baseUrl}settings";
  static const String updateSettings = "${baseUrl}settings/update";

  static const String patientList = "${baseUrl}patients";
  static const String actionPatient = "${baseUrl}reassign-surgeries-action/";
  static const String createPatient = "${baseUrl}patient-create";
  static const String userList = "${baseUrl}users";
  static const String userCreate = "${baseUrl}user/create";
  static const String reassignSurgeries = "${baseUrl}reassign-surgeries";
  static const String addReassignSurgeries =
      "${baseUrl}reassign-surgeries-create";

  //Doctor

  // TREATMENT
  static const String treatment = "${baseUrl}teatments";
  static const String createTreatment = "${baseUrl}teatment/create";
  static const String updateTreatment = "${baseUrl}teatment/update/";

  // Global
  static const String notification = "${baseUrl}notifications";
  static const String myNotification = "${baseUrl}my-notification";
  static const String readNotification = "${baseUrl}notification/read/";
  static const String readAllNotification = "${baseUrl}notifications";
  static const String getDashboard = "${baseUrl}dashboard";
}
