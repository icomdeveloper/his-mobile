import 'package:his/features/category/data/model/media_model.dart';

MediaModel dummyMedia = MediaModel(
  id: 0,
  title:
      'titletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitle',
  description:
      'descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription',
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

List<MediaModel> dummyMediaList = [dummyMedia, dummyMedia, dummyMedia];
