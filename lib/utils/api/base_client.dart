import 'package:dio/dio.dart';

class ApiHelper {
  static final ApiHelper _instance = ApiHelper();
  static ApiHelper get instance => _instance;
  final Dio dio = Dio(); // Create a Dio instance

  Future<Response<dynamic>> getRequest(String url) async {
    try {
      final response = await dio.get(url);
      return response;
    } catch (error, stacktrace) {
      print('GET Request Error: $error');
      print('Stacktrace: $stacktrace');
      throw error;
    }
  }

  Future<Response<dynamic>> postRequest(
      String url, Map<String, dynamic> data) async {
    try {
      final response = await dio.post(url, data: data);
      return response;
    } catch (error, stacktrace) {
      print('POST Request Error: $error');
      print('Stacktrace: $stacktrace');
      throw error;
    }
  }
}
