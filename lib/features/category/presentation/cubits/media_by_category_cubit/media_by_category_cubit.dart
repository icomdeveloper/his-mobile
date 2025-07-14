import 'package:bloc/bloc.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/category/data/repo/media_by_category_repo.dart';
import 'package:meta/meta.dart';

part 'media_by_category_state.dart';

class MediaByCategoryCubit extends Cubit<MediaByCategoryState> {
  MediaByCategoryCubit(this.mediaByCategoryRepo)
      : super(MediaByCategoryInitial());
  final MediaByCategoryRepo mediaByCategoryRepo;

  Future<void> getMediaByCategory({required int categoryId}) async {
    emit(MediaByCategoryLoading());
    final result =
        await mediaByCategoryRepo.getMediaByCategory(categoryId: categoryId);
    if (isClosed) return;
    result.fold((l) => emit(MediaByCategoryFailure(errMessage: l.errMesage)),
        (mediaList) => emit(MediaByCategorySuccess(mediaList: mediaList)));
  }
}
