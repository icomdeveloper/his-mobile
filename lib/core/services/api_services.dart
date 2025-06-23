import 'package:dio/dio.dart';

class ApiServices {
  final String baseUrl = 'https://his.mc-apps.org/api/';
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

  Future getCommentMethod(
      {required String endPoint,
      required int mediaId,
      bool isArticle = false}) async {
    String parameterName = 'media_id';
    if (isArticle) {
      parameterName = 'article_id';
    }
    final response = await dio.get('$baseUrl$endPoint?$parameterName=$mediaId');
    return response.data;
  }
}
