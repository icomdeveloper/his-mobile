import 'package:bloc/bloc.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/category/data/repo/show_media_repo.dart';
import 'package:meta/meta.dart';

part 'get_media_state.dart';

class GetMediaCubit extends Cubit<GetMediaState> {
  GetMediaCubit(this.showMediaRepo) : super(GetMediaInitial());
  final ShowMediaRepo showMediaRepo;
  Future<void> getVideos() async {
    emit(GetMediaLoading());
    var result = await showMediaRepo.showVideos();
    result.fold((error) => emit(GetMediaFailure(message: error.errMesage)),
        (success) => emit(GetMediaSuccess(mediaList: success)));
  }
}
