import 'package:bloc/bloc.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/category/data/repo/media_details_repo.dart';
import 'package:meta/meta.dart';

part 'media_details_state.dart';

class MediaDetailsCubit extends Cubit<MediaDetailsState> {
  MediaDetailsCubit(this.mediaDetailsRepo) : super(MediaDetailsInitial());
  final MediaDetailsRepo mediaDetailsRepo;

  Future<void> getMediaDetails({required int mediaId}) async {
    emit(MediaDetailsLoading());
    final result = await mediaDetailsRepo.getMediaDetails(mediaId: mediaId);
    if (isClosed) return;
    result.fold(
        (failure) => emit(MediaDetailsFailure(errMesage: failure.errMesage)),
        (mediaDetails) => emit(MediaDetailsSuccess(mediaModel: mediaDetails)));
  }
}
