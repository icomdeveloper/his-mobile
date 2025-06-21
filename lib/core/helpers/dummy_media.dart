import 'package:his/features/authentication/data/models/user_data/user_information.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/home/data/models/article_model.dart';
import 'package:his/features/home/data/models/comments_model/comments_model.dart';

final MediaModel dummyMedia = MediaModel(
  id: 0,
  title:
      'titletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitle',
  description:
      'descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription',
  filePath:
      'https://drive.google.com/file/d/1HYY3HTLQWD6rAMLhZUeTdip5z0Xr24XY/preview',
  pdf: 'pdf',
  duration: 'duration',
  thumbnailPath:
      'https://images.squarespace-cdn.com/content/v1/60f1a490a90ed8713c41c36c/1629223610791-LCBJG5451DRKX4WOB4SP/37-design-powers-url-structure.jpeg',
  status: 'status',
  isFeatured: 1,
  isRecommended: 1,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  views: '',
  categoryId: 0,
  userId: 0,
);

final List<MediaModel> dummyMediaList = [dummyMedia, dummyMedia, dummyMedia];

final ArticleModel dummyArticle = ArticleModel(
  id: 0,
  title:
      'titletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitle',
  description:
      'descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptescriptiondescription',
  image:
      'https://images.squarespace-cdn.com/content/v1/60f1a490a90ed8713c41c36c/1629223610791-LCBJG5451DRKX4WOB4SP/37-design-powers-url-structure.jpeg',
  pdf: 'pdf',
  hyperlink: 'hyperlinkhyperlinkhyperlinkhyperlink',
  isFeatured: "0",
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  categoryId: 0,
  userId: 0,
);

final List<ArticleModel> dummyArticleList = [
  dummyArticle,
  dummyArticle,
  dummyArticle
];
final CommentsModel dummyComment = CommentsModel(
  id: 0,
  mediaId: 0,
  userId: 0,
  content: 'sadasd asdasdas asdasdas asdasda asdasdad asdasdasdasdasd',
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  parentId: 0,
  user: dummyUserInfo,
);

final UserInformation dummyUserInfo = UserInformation(
  name: 'name name',
  email: 'email@gmail.com',
  role: 'role',
  username: 'username',
);

final List<CommentsModel> dummyCommentList = [
  dummyComment,
  dummyComment,
  dummyComment
];
