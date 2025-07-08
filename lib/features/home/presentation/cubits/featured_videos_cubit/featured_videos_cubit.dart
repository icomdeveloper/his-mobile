import 'package:bloc/bloc.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/home/data/repo/featured_videos_repo.dart';
import 'package:meta/meta.dart';

part 'featured_videos_state.dart';

class FeaturedVideosCubit extends Cubit<FeaturedVideosState> {
  FeaturedVideosCubit(this.featuredVideosRepo) : super(FeaturedVideosInitial());
  final FeaturedVideosRepo featuredVideosRepo;

  Future<void> getFeaturedVideos() async {
    emit(FeaturedVideosLoading());
    final data = await featuredVideosRepo.getFeaturedVideos();
    if (isClosed) return;
    data.fold(
        (failure) => emit(FeaturedVideosFailure(errMessage: failure.errMesage)),
        (list) => emit(FeaturedVideosSuccess(mediaList: list)));
  }
}
