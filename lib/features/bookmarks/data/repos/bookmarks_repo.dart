import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/bookmarks/data/models/bookmarks_model/bookmarks_model.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/home/data/models/article_model.dart';

class BookmarksRepo {
  final ApiServices apiServices;

  BookmarksRepo({required this.apiServices});
  Future<Either<Failure, dynamic>> addToBookmarks(
      {int? mediaId, int? articleId}) async {
    Map<String, dynamic> data = {
      ApiEndpoints.userId: getUserData().userInfo?.id,
      'flag': "1",
    };
    try {
      if (mediaId != null) {
        data[ApiEndpoints.mediaId] = mediaId;
      } else {
        data[ApiEndpoints.articleid] = articleId;
      }
      final response = await apiServices.postMethodWithToken(
        endPoint: ApiEndpoints.addToBookmarks,
        data: data,
        token: getUserData().token,
      );
      return Right(response['message']);
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        return Left(ServerFailure(errMesage: e.response?.data['message']));
      }
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }

  /// Removes a bookmark from the user's bookmarks.
  ///
  /// If [mediaId] is non-null, then a bookmark for the media item with that ID will be removed.
  /// If [articleId] is non-null, then a bookmark for the article with that ID will be removed.
  ///
  /// Returns a [Right] containing the response message if the request succeeds, or a [Left] containing a [Failure] if the request fails.
  Future<Either<Failure, dynamic>> removeFromBookmarks(
      {int? mediaId, int? articleId}) async {
    Map<String, dynamic> data = {
      ApiEndpoints.userId: getUserData().userInfo?.id,
    };
    try {
      if (mediaId != null) {
        data[ApiEndpoints.mediaId] = mediaId;
      } else {
        data[ApiEndpoints.articleid] = articleId;
      }
      final response = await apiServices.postMethodWithToken(
          endPoint: ApiEndpoints.removeFromBookmarks,
          data: data,
          token: getUserData().token);
      return Right(response['message']);
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        return Left(ServerFailure(errMesage: e.response?.data['message']));
      }
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }

  Future<Either<Failure, List<MediaModel>>> getBookmarksVideos() async {
    try {
      final data = {ApiEndpoints.userId: getUserData().userInfo?.id};
      final response = await apiServices.getMethod(
          endPoint: ApiEndpoints.bookmarks,
          data: data,
          token: getUserData().token);

      Map<String, dynamic> bookmarkData = response['data'];
      List<dynamic> bookmarks = bookmarkData['bookmarks'];
      // List<dynamic> mediaBookmarks = bookmarks['mediaBookmarks'];

      List<BookmarksModel> bookmarkList =
          bookmarks.map((e) => BookmarksModel.fromJsonToMedia(e)).toList();
      if (bookmarkList.isEmpty) {
        return const Right([]);
      }

      List<MediaModel> mediaList =
          bookmarkList.map((e) => MediaModel.fromMedia(e.mediaModel!)).toList();
      return Right(mediaList);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errMesage: 'You may not have any videos yet'));
    }
  }

  Future<Either<Failure, List<ArticleModel>>> getBookmarksArticles() async {
    try {
      final data = {ApiEndpoints.userId: getUserData().userInfo?.id};
      final response = await apiServices.getMethod(
          endPoint: ApiEndpoints.bookmarks, data: data);

      Map<String, dynamic> bookmarkData = response['data'];
      Map<String, dynamic> bookmarks = bookmarkData['bookmarks'];
      List<dynamic> articleBookmarks = bookmarks['articleBookmarks'];

      List<BookmarksModel> bookmarkList = articleBookmarks
          .map((e) => BookmarksModel.fromJsonToArticle(e))
          .toList();
      if (bookmarkList.isEmpty) {
        return const Right([]);
      }

      List<ArticleModel> articleList = bookmarkList
          .map((e) => ArticleModel.fromArticle(e.articleModel!))
          .toList();
      return Right(articleList);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(
          errMesage: 'You may not have any articles yet , try again'));
    }
  }
}
