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
      'https://cdn.prod.website-files.com/6009ec8cda7f305645c9d91b/601082646d6bf4446451b0a4_6002086f72b72717ae01d954_google-doc-error-message.png',
  image:
      'https://drive.google.com/file/d/16Dq97iZ-gojFW6cqenBKKLjOmZgqEmr2/preview',
  status: 'pending',
  isFeatured: 1,
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
  thumbnailImage:
      'https://images.squarespace-cdn.com/content/v1/60f1a490a90ed8713c41c36c/1629223610791-LCBJG5451DRKX4WOB4SP/37-design-powers-url-structure.jpeg',
  image:
      'https://images.squarespace-cdn.com/content/v1/60f1a490a90ed8713c41c36c/1629223610791-LCBJG5451DRKX4WOB4SP/37-design-powers-url-structure.jpeg',
  pdf: 'pdf',
  hyperlink: 'hyperlinkhyperlinkhyperlinkhyperlink',
  isFeatured: '1',
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  categoryId: 0,
  userId: 0,
);

final List<ArticleModel> dummyArticleList = [
  dummyArticle,
  dummyArticle,
  dummyArticle,
  dummyArticle,
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
);

final List<CommentsModel> dummyCommentList = [
  dummyComment,
  dummyComment,
  dummyComment
];
