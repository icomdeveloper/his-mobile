import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/features/authentication/data/repo/auth_repo.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<ApiServices>(ApiServices(dio: setupDio()));
  getIt
      .registerSingleton<AuthRepo>(AuthRepo(apiServices: getIt<ApiServices>()));
}

Dio setupDio() {
  Dio dio = Dio();
  dio.options.connectTimeout = const Duration(seconds: 20);
  dio.options.sendTimeout = const Duration(seconds: 20);

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
