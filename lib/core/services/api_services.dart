import 'package:dio/dio.dart';

class ApiServices {
  final String baseUrl = 'http://192.168.1.53:8000/api/';
  final Dio dio;

  ApiServices({required this.dio});
  Future postMethod(
      {required String endPoint,
      required Map<String, dynamic> data,
      bool isFormData = false}) async {
    final response = await dio.post(
      '$baseUrl$endPoint',
      data: isFormData ? FormData.fromMap(data) : data,
    );
    return response.data;
  }

  Future getMethod({required String endPoint}) async {
    final response = await dio.get('$baseUrl$endPoint');
    return response.data;
  }
}
