import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/features/authentication/data/repo/login_repo.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<ApiServices>(ApiServices(dio: setupDio()));
  getIt.registerSingleton<LoginRepo>(
      LoginRepo(apiServices: getIt<ApiServices>()));
}

Dio setupDio() {
  Dio dio = Dio();

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
