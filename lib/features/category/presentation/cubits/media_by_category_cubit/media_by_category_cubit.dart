import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/category/data/repo/media_by_category_repo.dart';

part 'media_by_category_state.dart';

class MediaByCategoryCubit extends Cubit<MediaByCategoryState> {
  MediaByCategoryCubit(this.mediaByCategoryRepo)
      : super(MediaByCategoryInitial());
  final MediaByCategoryRepo mediaByCategoryRepo;

  Future<void> getMediaByCategory(
      {required int categoryId, required BuildContext context}) async {
    emit(MediaByCategoryLoading());
    final result = await mediaByCategoryRepo.getMediaByCategory(
        categoryId: categoryId, context: context);
    if (isClosed) return;
    result.fold((l) => emit(MediaByCategoryFailure(errMessage: l.errMesage)),
        (mediaList) => emit(MediaByCategorySuccess(mediaList: mediaList)));
  }
}
