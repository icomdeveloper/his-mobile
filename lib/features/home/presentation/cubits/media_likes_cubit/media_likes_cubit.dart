import 'package:bloc/bloc.dart';
import 'package:his/features/home/data/repo/media_likes_repo.dart';
import 'package:meta/meta.dart';

part 'media_likes_state.dart';

class MediaLikesCubit extends Cubit<MediaLikesState> {
  MediaLikesCubit(this.mediaLikesRepo) : super(MediaLikesInitial());
  final MediaLikesRepo mediaLikesRepo;

  Future<void> addLike({required int mediaId}) async {
    emit(MediaLikesInitial());
    final result = await mediaLikesRepo.addLike(id: mediaId, endPoint: 'media');
    result.fold((l) => emit(AddLikeFailure(message: l.errMesage)),
        (r) => emit(AddLikeSuccess()));
  }

  Future<void> deleteLike({required int mediaId}) async {
    emit(MediaLikesInitial());
    final result =
        await mediaLikesRepo.deleteLike(id: mediaId, endPoint: 'media');
    result.fold((l) => emit(DeleteLikeFailure(message: l.errMesage)),
        (r) => emit(DeleteLikeSuccess()));
  }
}
