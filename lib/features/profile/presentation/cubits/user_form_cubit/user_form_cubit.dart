import 'package:bloc/bloc.dart';
import 'package:his/features/profile/data/model/user_form_model.dart';
import 'package:his/features/profile/data/repo/user_videos_repo.dart';
import 'package:meta/meta.dart';

part 'user_form_state.dart';

class UserFormCubit extends Cubit<UserFormState> {
  UserFormCubit(this.userVideosRepo) : super(UserFormInitial());
  final UserVideosRepo userVideosRepo;

  Future<void> getUserForm({required String id}) async {
    emit(UserFormLoading());
    final result = await userVideosRepo.userForm(id: id);
    result.fold((l) => emit(UserFormFailure(errMesage: l.errMesage)),
        (r) => emit(UserFormSuccess(userFormModel: r)));
  }
}
