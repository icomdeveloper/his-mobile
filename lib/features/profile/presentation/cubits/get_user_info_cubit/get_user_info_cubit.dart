import 'package:bloc/bloc.dart';
import 'package:his/features/authentication/data/models/user_data/user_information.dart';
import 'package:his/features/profile/data/repo/get_users_repo.dart';
import 'package:meta/meta.dart';

part 'get_user_info_state.dart';

class GetUserInfoCubit extends Cubit<GetUserInfoState> {
  GetUserInfoCubit(this.getUserInfoRepo) : super(GetUserInfoInitial());
  final GetUsersRepo getUserInfoRepo;

  Future<void> getUserInfo() async {
    emit(GetUserInfoInitial());
    final result = await getUserInfoRepo.getUserInfo();
    result.fold((l) => emit(GetUserInfoFailure(errMesage: l.errMesage)),
        (r) => emit(GetUserInfoSuccess(userInfo: r)));
  }
}
