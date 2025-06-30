import 'package:bloc/bloc.dart';
import 'package:his/features/home/data/repo/media_likes_repo.dart';
import 'package:meta/meta.dart';

part 'comment_like_state.dart';

class CommentLikeCubit extends Cubit<CommentLikeState> {
  CommentLikeCubit(this.mediaLikesRepo) : super(CommentLikeInitial());
  final MediaLikesRepo mediaLikesRepo;

  Future<void> addLike({required int commentId}) async {
    emit(CommentLikeInitial());
    final result =
        await mediaLikesRepo.addLike(id: commentId, endPoint: 'comment');
    result.fold((l) => emit(AddLikeFailure(message: l.errMesage)),
        (r) => emit(AddLikeSuccess()));
  }

  Future<void> deleteLike({required int commentId}) async {
    emit(CommentLikeInitial());
    final result =
        await mediaLikesRepo.deleteLike(id: commentId, endPoint: 'comment');
    result.fold((l) => emit(DeleteLikeFailure(message: l.errMesage)),
        (r) => emit(DeleteLikeSuccess()));
  }
}
