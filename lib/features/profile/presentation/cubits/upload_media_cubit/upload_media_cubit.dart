import 'package:bloc/bloc.dart';
import 'package:his/features/profile/data/model/upload_video_model.dart';
import 'package:his/features/profile/data/repo/upload_video_repo.dart';
import 'package:meta/meta.dart';

part 'upload_media_state.dart';

class UploadMediaCubit extends Cubit<UploadMediaState> {
  UploadMediaCubit(this.uploadVideoRepo) : super(UploadMediaInitial());
  final UploadVideoRepo uploadVideoRepo;

  Future<void> uploadVideo({required UploadVideoModel uploadVideoModel}) async {
    emit(UploadMediaLoading());
    var result =
        await uploadVideoRepo.uploadVideo(uploadVideoModel: uploadVideoModel);
    if (isClosed) return;
    result.fold((error) => emit(UploadMediaFailure(message: error.errMesage)),
        (r) => emit(UploadMediaSuccess()));
  }
}
