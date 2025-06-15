import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:his/constants.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/services/firebase_auth_services.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/authentication/data/models/login_model.dart';
import 'package:his/features/authentication/data/models/register_model.dart';
import 'package:his/features/authentication/data/models/register_success_model/register_success_model.dart';
import 'package:his/features/authentication/data/models/user_data/user_data.dart';

class AuthRepo {
  final ApiServices apiServices;
  final FirebaseAuthServices firebaseAuthServices;

  AuthRepo({required this.apiServices, required this.firebaseAuthServices});
  Future<Either<ServerFailure, UserData>> login(
      {required LoginModel loginModel}) async {
    try {
      var data = await apiServices.postMethod(
          endPoint: ApiEndpoints.login, data: loginModel.toJson());
      await saveUserData(user: UserData.fromJson(data));
      return right(UserData.fromJson(data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }

  Future<Either<ServerFailure, RegisterSuccessModel>> register(
      {required RegisterModel registerModel}) async {
    try {
      var data = await apiServices.postMethod(
          endPoint: ApiEndpoints.register, data: registerModel.toJson());
      return right(RegisterSuccessModel.fromJson(data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }

  Future<Either<ServerFailure, UserData>> signInWithGoogle() async {
    try {
      UserCredential user = await firebaseAuthServices.signInWithGoogle();

      var data = await apiServices.postMethod(
          endPoint: ApiEndpoints.googleLogin,
          data: {ApiEndpoints.googleIdToken: user.credential!.accessToken});

      await saveUserData(user: UserData.fromJson(data));
      return right(UserData.fromJson(data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }

  // Future<Either<ServerFailure, UserData>> signInWithApple() async {
  //   try {
  //     User user = await firebaseAuthServices.signInWithApple();
  //     UserData userModel = UserData.fromFirebase(user);
  //     return right(userModel);
  //   } catch (e) {
  //     return left(ServerFailure(errMesage: 'Something went wrong , try again'));
  //   }
  // }

  Future saveUserData({required UserData user}) async {
    var jsonData = jsonEncode(user.toJson());
    await Prefs.setString(PrefsKeys.userData, jsonData);
  }
}
