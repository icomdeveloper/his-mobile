import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/services/firebase_auth_services.dart';
import 'package:his/features/authentication/data/repo/auth_repo.dart';
import 'package:his/features/category/data/repo/comments_repo.dart';
import 'package:his/features/category/data/repo/show_media_repo.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<ApiServices>(ApiServices(dio: setupDio()));
  getIt.registerSingleton<FirebaseAuthServices>(FirebaseAuthServices());
  getIt.registerSingleton<AuthRepo>(AuthRepo(
      apiServices: getIt<ApiServices>(),
      firebaseAuthServices: getIt<FirebaseAuthServices>()));
  getIt.registerSingleton<ShowMediaRepo>(
      ShowMediaRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<CommentRepo>(
      CommentRepo(apiServices: getIt<ApiServices>()));
}

Dio setupDio() {
  Dio dio = Dio();
  dio.options.connectTimeout = const Duration(seconds: 40);
  dio.options.sendTimeout = const Duration(seconds: 40);

  dio.interceptors.add(
    LogInterceptor(
      responseBody: true,
      requestBody: true,
      error: true,
      request: true,
      requestHeader: false,
      responseHeader: false,
    ),
  );
  return dio;
}
