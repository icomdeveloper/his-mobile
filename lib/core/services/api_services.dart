import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:his/core/errors/exceptions.dart';

class ApiServices {
  final String baseUrl = 'https://127.0.0.1:8000/api/';
  final Dio dio;

  ApiServices({required this.dio});
  Future postMethod(
      {required String endPoint, required Map<String, dynamic> data}) async {
    try {
      final response = await dio.post(
        '$baseUrl $endPoint',
        data: data,
      );
      log('Step3 ==>$response');
      return response.data;
    } on DioException catch (e) {
      throw Customexception(e.toString());
    } on Exception catch (e) {
      throw Customexception(e.toString());
    }
  }
}
