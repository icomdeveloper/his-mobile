import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/category/data/model/add_comment_model.dart';
import 'package:his/features/home/data/models/comments_model/comments_model.dart';
import 'package:his/features/home/data/models/comments_model/reply_model.dart';

class CommentRepo {
  final ApiServices apiServices;

  CommentRepo({required this.apiServices});
  Future<Either<ServerFailure, dynamic>> addComment(
      {required AddCommentModel comment}) async {
    try {
      var data = await apiServices.postMethod(
          endPoint: ApiEndpoints.addComment, data: comment.toJson());
      dynamic addedComment = data['data'];
      return right(CommentsModel.fromJson(addedComment));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }

  Future<Either<ServerFailure, ReplyModel>> addReply(
      {required AddCommentModel reply}) async {
    try {
      var data = await apiServices.postMethod(
          endPoint: ApiEndpoints.reply, data: reply.toJson());
      return right(ReplyModel.fromJson(data['data']));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }

  Future<Either<ServerFailure, List<CommentsModel>>> getComments(
      {required int mediaId, bool isArticle = false}) async {
    try {
      var data = await apiServices.getCommentMethod(
        endPoint: ApiEndpoints.getMediaComments,
        mediaId: mediaId,
        isArticle: isArticle,
      );
      List<dynamic> commentsList = data['data'];
      return right(commentsList.map((e) => CommentsModel.fromJson(e)).toList());
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
