import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/category/data/model/comment_model.dart';

class CommentRepo {
  final ApiServices apiServices;

  CommentRepo({required this.apiServices});
  Future<Either<ServerFailure, dynamic>> addComment(
      {required CommentModel comment}) async {
    try {
      var data = await apiServices.postMethod(
          endPoint: ApiEndpoints.comments, data: comment.toJson());
      return right(data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }

  Future<Either<ServerFailure, dynamic>> addReply(
      {required CommentModel reply}) async {
    try {
      var data = await apiServices.postMethod(
          endPoint: ApiEndpoints.reply, data: reply.toJson());
      return right(data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
