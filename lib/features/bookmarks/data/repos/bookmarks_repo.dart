import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/bookmarks/data/models/bookmarks_model/bookmarks_model.dart';
import 'package:his/features/category/data/model/media_model.dart';

class BookmarksRepo {
  final ApiServices apiServices;

  BookmarksRepo({required this.apiServices});
  Future<Either<Failure, dynamic>> addToBookmarks(
      {int? mediaId, int? articleId}) async {
    Map<String, dynamic> data = {
      ApiEndpoints.userId: getUserData().userInfo!.id,
      'flag': "1",
    };
    try {
      if (mediaId != null) {
        data[ApiEndpoints.mediaId] = mediaId;
      } else {
        data[ApiEndpoints.articleid] = articleId;
      }
      final response = await apiServices.postMethod(
          endPoint: ApiEndpoints.addToBookmarks, data: data);
      return Right(response['message']);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }

  Future<Either<Failure, dynamic>> removeFromBookmarks(
      {int? mediaId, int? articleId}) async {
    Map<String, dynamic> data = {
      ApiEndpoints.userId: getUserData().userInfo!.id,
    };
    try {
      if (mediaId != null) {
        data[ApiEndpoints.mediaId] = mediaId;
      } else {
        data[ApiEndpoints.articleid] = articleId;
      }
      final response = await apiServices.postMethod(
          endPoint: ApiEndpoints.removeFromBookmarks, data: data);
      return Right(response['message']);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }

  Future<Either<Failure, List<MediaModel>>> getBookmarks() async {
    try {
      final data = await apiServices.getMethod(
          endPoint: ApiEndpoints.bookmarks,
          data: {ApiEndpoints.userId: getUserData().userInfo!.id});

      List<dynamic> bookmarkData = data['data'];

      List<BookmarksModel> bookmarkList =
          bookmarkData.map((e) => BookmarksModel.fromJson(e)).toList();

      return Right(
          bookmarkList.map((e) => MediaModel.fromBookmarks(e.item!)).toList());
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
