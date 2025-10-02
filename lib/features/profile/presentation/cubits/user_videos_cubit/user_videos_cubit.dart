import 'package:bloc/bloc.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/profile/data/repo/user_videos_repo.dart';
import 'package:meta/meta.dart';

part 'user_videos_state.dart';

class UserVideosCubit extends Cubit<UserVideosState> {
  UserVideosCubit(this.userVideosRepo) : super(UserVideosInitial());
  final UserVideosRepo userVideosRepo;

  Future<void> userVideos() async {
    emit(GetUserVideosLoading());
    final result = await userVideosRepo.userVideos();
    if (isClosed) return;
    result.fold(
        (failure) => emit(GetUserVideosFailure(errMessage: failure.errMesage)),
        (success) => emit(GetUserVideosSuccess(mediaMap: success)));
  }

  // Future<void> userPendingVideos() async {
  //   emit(GetPendingLoading());
  //   final result = await userVideosRepo.userVideosPending();
  //   if (isClosed) return;
  //   result.fold(
  //       (failure) => emit(GetPendingFailure(errMessage: failure.errMesage)),
  //       (success) => emit(GetPendingSuccess(mediaList: success)));
  // }
}
