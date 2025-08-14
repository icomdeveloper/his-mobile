abstract class ApiEndpoints {
  static const String login = 'login';
  static const String password = 'password';

  static const String register = 'register';
  static const String name = 'name';
  static const String email = 'email';
  static const String phone = 'phone';

  static const String role = 'role';
  static const String passwordConfirmation = 'password_confirmation';

  static const String showMedia = 'media/show';
  static const String mediaId = 'media_id';
  static const String userId = 'user_id';
  static const String parentId = 'parent_id';
  static const String content = 'content';
  static const String addComment = 'comments';

  static const String reply = 'comments/reply';

  static const String uploadVideo = 'media/store';
  static const String uploadArticle = 'article/store';
  static const String categoryId = 'category_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String file = 'file';
  static const String thumbnail = 'thumbnail_path';

  static const String imagePath = 'image_path';

  static const String isFeatured = 'is_featured';
  static const String pdf = 'pdf';

  static const String recentlyAdded = 'media/recently_Added';

  static const String googleLogin = 'login/google';

  static const String googleIdToken = 'id_token';
  static const String featuredVideos = 'media/featured';
  static const String showArticles = 'article/show';
  static const String getMediaComments = 'comments/media';

  static const String resetPassword = 'password/reset';
  static const String year = 'year';

  static const String month = 'month';
  static const String addToBookmarks = 'bookmarks/add';

  static const String removeFromBookmarks = 'bookmarks/remove';

  static const String articleid = 'article_id';

  static const String bookmarks = 'bookmarks';
  static const String deleteUser = 'profile';

  static const String updateProfile = 'profile';
  static const String profileImage = 'profile_image';

  static const String search = 'search';
  static const String tokenId = 'token_id';

  static const String hyperlink = 'hyperlink';
  static const String viewscount = 'viewscount';
  static const String userArticles = 'user_articles';
  static const String userVideos = 'user_media';
  static const String updateProfileImage = 'updateProfileImage';

  static const String mediaDetails = 'media_details';

  static const String categories = 'categories';

  static const String categoryMedia = 'category_media';

  static const String showAdminComments = 'show/admin-comments';
  static const String addAdminComment = 'add/admin-comments';
  static const String addAdminReply = 'reply/admin-comments';
  static const String editMedia = 'update_media';

  static const String deleteMedia = 'delete/media';

  static const String mention = 'mention';
  static const String fcmToken = 'fcm_token';
  static const String notificationsFcmToken = 'notifications/fcm-token';
  static const String notifications = "notifications";

  static const String academicTitle = "academic_title";
  static const String jobDescription = "job_description";
  static const String yearOfGraduation = "year_of_graduation";
  static const String countryOfPractices = "country_of_practices";
  static const String institution = "institution";
  static const String department = "department";
  static const String countryOfGraduation = "country_of_graduation";
  static const String userInfo = "user_info";
  static const String deleteComment = "delete/comment";
  static const String commentId = "comment_id";
}
