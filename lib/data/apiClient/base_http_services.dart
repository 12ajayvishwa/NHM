abstract class BaseHttpServices {
  Future<dynamic> get(String endPoint);
  Future<dynamic> post(String endPoint, dynamic body,bool isEncoded);
  Future<dynamic> put(String endPoint, dynamic body,bool isEncoded);
  Future<dynamic> delete(String endPoint);
  Future<dynamic> formData(
    String endPoint,
    dynamic file,
    dynamic body,
    String method,
  );
}
