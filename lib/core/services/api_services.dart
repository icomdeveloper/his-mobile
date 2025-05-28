import 'package:dio/dio.dart';

class ApiServices {
  final String baseUrl = 'http://192.168.5.121:8000/api/';
  final Dio dio;

  ApiServices({required this.dio});
  Future postMethod(
      {required String endPoint, required Map<String, dynamic> data}) async {
    final response = await dio.post(
      '$baseUrl$endPoint',
      data: data,
    );
    return response.data;
  }
}
