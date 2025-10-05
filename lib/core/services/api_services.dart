import 'package:dio/dio.dart';

class ApiServices {
  String baseUrl = 'https://admin.hypospadias-journals.com/api/';
  final Dio dio;

  ApiServices({required this.dio});
  Future postMethod(
      {required String endPoint,
      required Object data,
      bool isFormData = false}) async {
    final response = await dio.post(
      '$baseUrl$endPoint',
      data: data,
      options: isFormData
          ? Options(
              headers: {
                'Content-Type': 'multipart/form-data',
                'Accept': 'application/json'
              },
            )
          : null,
    );
    return response.data;
  }

  Future postMethodWithToken({
    required String endPoint,
    required Object data,
    String? token,
  }) async {
    final response = await dio.post(
      '$baseUrl$endPoint',
      data: data,
      options: Options(
        headers: token == null
            ? {
                'Accept': 'application/json',
              }
            : {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
      ),
    );
    return response.data;
  }

  Future deleteMethod({required String endPoint, required Object data}) async {
    final response = await dio.delete(
      '$baseUrl$endPoint',
      data: data,
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    );
    return response.data;
  }

  Future getMethod(
      {required String endPoint, Object? data, String? token}) async {
    final response = await dio.get(
      '$baseUrl$endPoint',
      queryParameters: data as Map<String, dynamic>?,
      options: Options(
        headers: token == null
            ? {
                'Accept': 'application/json',
              }
            : {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
      ),
    );
    return response.data;
  }

  // Future getBookmarks({required String endPoint, required int id}) async {
  //   final response = await dio.get(
  //     '$baseUrl$endPoint/$id',
  //     options: Options(
  //       headers: {
  //         'Accept': 'application/json',
  //       },
  //     ),
  //   );
  //   return response.data;
  // }

  Future getCommentMethod(
      {required String endPoint,
      required int mediaId,
      bool isArticle = false}) async {
    String parameterName = 'media_id';
    if (isArticle) {
      parameterName = 'article_id';
    }
    final response = await dio.get(
      '$baseUrl$endPoint?$parameterName=$mediaId',
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    );
    return response.data;
  }

  Future putMethod(
      {required String endPoint,
      required Object data,
      String? token,
      bool isFormData = false}) async {
    final response = await dio.put(
      '$baseUrl$endPoint',
      data: data,
      options: Options(
        headers: token == null
            ? {
                'Accept': 'application/json',
              }
            : {
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              },
      ),
    );
    return response.data;
  }
}
