import 'package:bloc/bloc.dart';
import 'package:his/features/profile/data/repo/delete_media_repo.dart';
import 'package:meta/meta.dart';

part 'delete_media_state.dart';

class DeleteMediaCubit extends Cubit<DeleteMediaState> {
  DeleteMediaCubit(this.deleteMediaRepo) : super(DeleteMediaInitial());
  final DeleteMediaRepo deleteMediaRepo;

  Future<void> deleteMedia({required int mediaId}) async {
    emit(DeleteMediaLoading());
    final result = await deleteMediaRepo.deleteMedia(mediaId: mediaId);
    if (isClosed) return;
    result.fold(
        (failure) => emit(DeleteMediaFailure(errMessage: failure.errMesage)),
        (message) => emit(DeleteMediaSuccess(message: message)));
  }
}
