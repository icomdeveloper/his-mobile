import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/services/firebase_auth_services.dart';
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
      log('Token==>${user.credential!.accessToken}');
      var data = await apiServices.postMethod(
          endPoint: ApiEndpoints.googleLogin,
          data: {ApiEndpoints.googleIdToken: user.credential!.accessToken});

      await saveUserData(user: UserData.fromJson(data));
      return right(UserData.fromJson(data));
    } on FirebaseAuthException catch (e) {
      debugPrint(
          "FIREBASE ERROR: ${e.code} - ${e.message}"); // Critical for debugging
      return left(ServerFailure(errMesage: e.message!));
    } on PlatformException catch (e) {
      debugPrint(
          "PLATFORM ERROR: ${e.code} - ${e.message}\n${e.stacktrace}"); // Android-specific errors
      return left(ServerFailure(errMesage: "Platform error: ${e.code}"));
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
}
