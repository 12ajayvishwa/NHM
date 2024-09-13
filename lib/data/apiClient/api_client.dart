import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../core/constants/app_export.dart';
import '../../core/constants/session_manager.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/custom_alert_dialog.dart';
import 'app_exceptions.dart';
import 'base_http_services.dart';


class NetworkHttpServices extends BaseHttpServices {
  var api = http.Client();
  dynamic res;

  var headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SessionManager.getToken()}',
  };

  @override
  Future<dynamic> get(String endPoint) async {
    try {
      var url = Uri.parse(endPoint);
      var response = await api
          .get(url, headers: headers)
          .timeout(const Duration(seconds: 10));
      res = returnResponse(response);

      printInfo(info: 'url$url');
      printInfo(info: 'res$res');
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on TimeoutException catch (e) {
      throw RequestTimeOut(e.message);
    }
    return res;
  }

  @override
  Future<dynamic> post(String endPoint, dynamic body, bool isEncoded) async {
    if (isEncoded) {
      headers.addAll({
        'Content-Type': 'application/json',
      });
    } else {
      headers.addAll({
        'Content-Type': 'application/x-www-form-urlencoded',
      });
    }

    try {
      var url = Uri.parse(endPoint);
      var response = await api
          .post(url,
              body: body,
              headers: SessionManager.getToken() != null ? headers : null)
          .timeout(const Duration(seconds: 10));
      // ignore: avoid_print
      print("jdasdad fsdf ${response.body}");
      res = returnResponse(response);
      printInfo(info: 'POST API CALLING');
      printInfo(info: 'url$url');
      printInfo(info: 'res$res');
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on TimeoutException catch (e) {
      throw RequestTimeOut(e.message);
    }
    return res;
  }

  @override
  Future<dynamic> put(String endPoint, dynamic body, bool isEncoded) async {
    if (isEncoded) {
      headers.addAll({
        'Content-Type': 'application/json',
      });
    } else {
      headers.addAll({
        'Content-Type': 'application/x-www-form-urlencoded',
      });
    }

    try {
      var url = Uri.parse(endPoint);
      var response = await api
          .put(url, body: body, headers: headers)
          .timeout(const Duration(seconds: 10));
      // ignore: avoid_print
      print("jdasdad fsdf ${response.body}");
      res = returnResponse(response);
      printInfo(info: 'PUT API CALLING');
      printInfo(info: 'url$url');
      printInfo(info: 'res$res');
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on TimeoutException catch (e) {
      throw RequestTimeOut(e.message);
    }
    return res;
  }

  @override
  Future<dynamic> delete(String endPoint) async {
    try {
      var url = Uri.parse(endPoint);
      var response = await api
          .delete(url, headers: headers)
          .timeout(const Duration(seconds: 10));
      res = returnResponse(response);
      printInfo(info: 'DELETE API CALLING');
      printInfo(info: 'url$url');
      printInfo(info: 'res$res');
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on TimeoutException catch (e) {
      throw RequestTimeOut(e.message);
    }
    return res;
  }

  @override
  Future<dynamic> formData(
    String endPoint,
    dynamic file,
    dynamic body,
    String method,
  ) async {
    try {
      var url = Uri.parse(endPoint);
      var request = http.MultipartRequest(method, url);
      request.headers.addAll(headers);
      file != null ? request.files.addAll(file) : null;
      body != null ? request.fields.addAll(body) : null;

      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      res = jsonDecode(responseString);
      printInfo(info: 'FORMDATA API CALLING');
      printInfo(info: 'url$url');
      printInfo(info: 'res$res');
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on TimeoutException catch (e) {
      throw RequestTimeOut(e.message);
    }
    return res;
  }

  dynamic  returnResponse(http.Response response) {
    String jsonString = response.body.toString();
    int startIndex = jsonString.indexOf('{');
    int endIndex = jsonString.lastIndexOf('}');
    String jsonSubstring = jsonString.substring(startIndex, endIndex + 1);
    Map<String, dynamic> jsonMap = json.decode(jsonSubstring);
    String errorMessage = jsonMap['message'];
    printInfo(info: 'statusCode${response.statusCode}');

    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(errorMessage);
      case 401:
      case 422:
        showDialog(
            context: Get.context!,
            builder: (context) {
              return CustomAlertDialog(
                  title: "Unauthorized",
                  message: errorMessage,
                  colors: Colors.yellow,
                  okTitle: "ok",
                  icon: Icons.error_outline,
                  onPressedOk: () {
                    SessionManager.removeToken();
                    Get.offAllNamed(AppRoutes.LOGIN);
                  });
            },
            barrierDismissible: false);

        throw UnauthorizedException(errorMessage);
      case 500:
        throw InternalServerException(errorMessage);
      default:
        throw InternalServerException(
            'Internal Server Error : ${response.statusCode}');
    }
  }
}
