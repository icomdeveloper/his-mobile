import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:his/core/repo/notifications_repo.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/services/firebase_auth_services.dart';
import 'package:his/features/authentication/data/repo/auth_repo.dart';
import 'package:his/features/bookmarks/data/repos/bookmarks_repo.dart';
import 'package:his/features/category/data/repo/categories_repo.dart';
import 'package:his/features/category/data/repo/comments_repo.dart';
import 'package:his/features/category/data/repo/media_by_category_repo.dart';
import 'package:his/features/category/data/repo/media_details_repo.dart';
import 'package:his/features/category/data/repo/show_media_repo.dart';
import 'package:his/features/home/data/repo/featured_videos_repo.dart';
import 'package:his/features/home/data/repo/global_search_repo.dart';
import 'package:his/features/home/data/repo/media_likes_repo.dart';
import 'package:his/features/home/data/repo/recently_added_repo.dart';
import 'package:his/features/profile/data/repo/delete_media_repo.dart';
import 'package:his/features/profile/data/repo/delete_user_repo.dart';
import 'package:his/features/profile/data/repo/edit_media_repo.dart';
import 'package:his/features/profile/data/repo/edit_profile_repo.dart';
import 'package:his/features/profile/data/repo/get_users_repo.dart';
import 'package:his/features/profile/data/repo/reset_password_repo.dart';
import 'package:his/features/profile/data/repo/update_profile_image_repo.dart';
import 'package:his/features/profile/data/repo/upload_article_repo.dart';
import 'package:his/features/profile/data/repo/upload_video_repo.dart';
import 'package:his/features/profile/data/repo/user_articles_repo.dart';
import 'package:his/features/profile/data/repo/user_videos_repo.dart';

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
  getIt.registerSingleton<UploadVideoRepo>(
      UploadVideoRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<RecentlyAddedRepo>(
      RecentlyAddedRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<FeaturedVideosRepo>(
      FeaturedVideosRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<ResetPasswordRepo>(
      ResetPasswordRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<MediaLikesRepo>(
      MediaLikesRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<BookmarksRepo>(
      BookmarksRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<DeleteUserRepo>(
      DeleteUserRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<EditProfileRepo>(
      EditProfileRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<GlobalSearchRepo>(
      GlobalSearchRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<UpdateProfileImageRepo>(
      UpdateProfileImageRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<UploadArticleRepo>(
      UploadArticleRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<UserArticlesRepo>(
      UserArticlesRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<UserVideosRepo>(
      UserVideosRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<MediaDetailsRepo>(
      MediaDetailsRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<CategoriesRepo>(
      CategoriesRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<MediaByCategoryRepo>(
      MediaByCategoryRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<EditMediaRepo>(
      EditMediaRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<DeleteMediaRepo>(
      DeleteMediaRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<GetUsersRepo>(
      GetUsersRepo(apiServices: getIt<ApiServices>()));
  getIt.registerSingleton<NotificationsRepo>(
      NotificationsRepo(apiServices: getIt<ApiServices>()));
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
