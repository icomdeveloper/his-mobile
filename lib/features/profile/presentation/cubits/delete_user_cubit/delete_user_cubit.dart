import 'package:bloc/bloc.dart';

import 'package:his/features/profile/data/repo/delete_user_repo.dart';
import 'package:meta/meta.dart';

part 'delete_user_state.dart';

class DeleteUserCubit extends Cubit<DeleteUserState> {
  DeleteUserCubit(this.deleteUserRepo) : super(DeleteUserInitial());
  final DeleteUserRepo deleteUserRepo;
  Future<void> deleteUser() async {
    emit(DeleteUserLoading());
    final result = await deleteUserRepo.deleteUser();
    if (isClosed) return;
    result.fold((failure) {
      emit(DeleteUserFailure(errMessage: failure.errMesage));
    }, (data) {
      emit(DeleteUserSuccess(message: data['message']));
    });
  }
}
