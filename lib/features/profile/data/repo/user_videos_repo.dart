import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/profile/data/model/user_form_model.dart';

class UserVideosRepo {
  final ApiServices apiServices;

  UserVideosRepo({required this.apiServices});

  Future<Either<Failure, Map<String, List<MediaModel>>>> userVideos() async {
    try {
      final data = await apiServices.getMethod(
          endPoint: ApiEndpoints.newUserVideos,
          // data: {ApiEndpoints.userId: getUserData().userInfo!.id},
          token: getUserData().token);
      Map<String, dynamic> mediaData = data['data'];
      List<dynamic> pendingMediaData = mediaData['pending'][0];
      List<dynamic> publishedMediaData = mediaData['published'][0];
      List<dynamic> inReviewMediaData = mediaData['in_review'][0];
      List<dynamic> inReviseMediaData = mediaData['revise'][0];
      List<dynamic> declinedMediaData = mediaData['declined'][0];

      List<MediaModel> pendingList =
          pendingMediaData.map((e) => MediaModel.fromJson(e)).toList();
      List<MediaModel> publishedList =
          publishedMediaData.map((e) => MediaModel.fromJson(e)).toList();
      List<MediaModel> inReviewList =
          inReviewMediaData.map((e) => MediaModel.fromJson(e)).toList();
      List<MediaModel> inReviseList =
          inReviseMediaData.map((e) => MediaModel.fromJson(e)).toList();
      List<MediaModel> declinedList =
          declinedMediaData.map((e) => MediaModel.fromJson(e)).toList();

      Map<String, List<MediaModel>> list = {
        'pending': pendingList,
        'published': publishedList,
        'in_review': inReviewList,
        'revise': inReviseList,
        'declined': declinedList,
      };
      return right(list);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }

  // Future<Either<Failure, List<MediaModel>>> userVideosPending() async {
  //   try {
  //     final data = await apiServices.getMethod(
  //         endPoint: ApiEndpoints.userVideos,
  //         // data: {ApiEndpoints.userId: getUserData().userInfo!.id},
  //         token: getUserData().token);
  //     Map<String, dynamic> mediaData = data['data'];
  //     List<dynamic> pendingMediaData = mediaData['pending'];
  //     if (pendingMediaData[0] is List) return const Right([]);

  //     List<MediaModel> list =
  //         pendingMediaData.map((e) => MediaModel.fromJson(e)).toList();
  //     return right(list);
  //   } on DioException catch (e) {
  //     return left(ServerFailure.fromDioException(e));
  //   } catch (e) {
  //     return left(ServerFailure(errMesage: 'Something went wrong , try again'));
  //   }
  // }

  // Future<Either<Failure, List<MediaModel>>> userVideos() async {
  //   try {
  //     final data = await apiServices.getMethod(
  //         endPoint: ApiEndpoints.userVideos,
  //         // data: {ApiEndpoints.userId: getUserData().userInfo!.id},
  //         token: getUserData().token);
  //     Map<String, dynamic> mediaData = data['data'];
  //     List<dynamic> publishedMediaData = mediaData['published'];
  //     if (publishedMediaData[0] is List) return const Right([]);

  //     List<MediaModel> list =
  //         publishedMediaData.map((e) => MediaModel.fromJson(e)).toList();
  //     return right(list);
  //   } on DioException catch (e) {
  //     return left(ServerFailure.fromDioException(e));
  //   } catch (e) {
  //     return left(ServerFailure(errMesage: 'Something went wrong , try again'));
  //   }
  // }

  Future<Either<Failure, UserFormModel>> userForm() async {
    try {
      final data = await apiServices.getMethod(
          endPoint: '${ApiEndpoints.userForms}/${getUserData().userInfo!.id}',
          token: getUserData().token);
      return Right(UserFormModel.fromJson(data));
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return left(ServerFailure(errMesage: 'User form not found'));
      }
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
