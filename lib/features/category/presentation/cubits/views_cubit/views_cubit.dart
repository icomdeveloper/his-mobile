import 'package:bloc/bloc.dart';
import 'package:his/features/category/data/repo/show_media_repo.dart';
import 'package:meta/meta.dart';

part 'views_state.dart';

class ViewsCubit extends Cubit<ViewsState> {
  ViewsCubit(this.showMediaRepo) : super(ViewsInitial());
  final ShowMediaRepo showMediaRepo;

  Future<void> incrementViews({required int mediaId}) async {
    emit(ViewsInitial());
    var result = await showMediaRepo.incrementViewsCount(mediaId: mediaId);
    result.fold((error) => emit(ViewsFailure(message: error.errMesage)),
        (success) => emit(ViewsSuccess(viewsCount: success)));
  }
}
