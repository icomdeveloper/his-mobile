import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
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
      var data = await apiServices.postMethodWithToken(
          token: getUserData().token,
          endPoint: ApiEndpoints.addComment,
          data: comment.toJson());
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
      var data = await apiServices.postMethodWithToken(
          token: getUserData().token,
          endPoint: ApiEndpoints.reply,
          data: reply.toJson());
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
      var data = await apiServices.getMethod(
        token: getUserData().token,
        endPoint: ApiEndpoints.getMediaComments,
        data: {
          ApiEndpoints.mediaId: mediaId,
          ApiEndpoints.userId: getUserData().userInfo!.id
        },
      );
      List<dynamic> commentsList = data['data'];
      return right(commentsList.map((e) => CommentsModel.fromJson(e)).toList());
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        return left(ServerFailure(
            errMesage: e.response?.data['errors']['media_id'][0]));
      }
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }

  Future<Either<Failure, List<CommentsModel>>> getAdminComments(
      {required int mediaId}) async {
    try {
      var data = await apiServices.getMethod(
        token: getUserData().token,
        endPoint: ApiEndpoints.showAdminComments,
        data: {
          ApiEndpoints.mediaId: mediaId,
        },
      );
      Map<String, dynamic> comments = data['data'];
      List<dynamic> commentsList = comments['AdminComments'];

      return right(commentsList.map((e) => CommentsModel.fromJson(e)).toList());
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }

  Future<Either<ServerFailure, dynamic>> addAdminComment(
      {required AddCommentModel comment}) async {
    try {
      var data = await apiServices.postMethodWithToken(
          token: getUserData().token,
          endPoint: ApiEndpoints.addAdminComment,
          data: comment.toJson());
      dynamic addedComment = data['comment'];
      return right(CommentsModel.fromJson(addedComment));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }

  Future<Either<ServerFailure, ReplyModel>> addAdminReply(
      {required AddCommentModel reply}) async {
    try {
      var data = await apiServices.postMethodWithToken(
          token: getUserData().token,
          endPoint: ApiEndpoints.addAdminReply,
          data: reply.toJson());
      return right(ReplyModel.fromJson(data['comment']));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }

  Future<Either<ServerFailure, dynamic>> deleteComment(
      {required int commentId}) async {
    try {
      var data = await apiServices.postMethodWithToken(
        endPoint: ApiEndpoints.deleteComment,
        token: getUserData().token,
        data: {
          ApiEndpoints.commentId: commentId,
          ApiEndpoints.userId: getUserData().userInfo?.id
        },
      );
      return right(data['message']);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
