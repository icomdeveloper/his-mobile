import 'package:bloc/bloc.dart';
import 'package:his/features/authentication/data/models/user_data/user_information.dart';
import 'package:his/features/profile/data/repo/get_users_repo.dart';
import 'package:meta/meta.dart';

part 'get_users_state.dart';

class GetUsersCubit extends Cubit<GetUsersState> {
  GetUsersCubit(this.getUsersRepo) : super(GetUsersInitial());
  final GetUsersRepo getUsersRepo;

  Future<void> getUsers() async {
    emit(GetUsersInitial());
    final result = await getUsersRepo.getUsers();
    result.fold(
        (failure) => emit(GetUsersFailure(errMesage: failure.errMesage)),
        (users) => emit(GetUsersSuccess(users: users)));
  }
}
