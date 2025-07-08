import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/features/authentication/data/models/user_data/user_information.dart';
import 'package:his/features/profile/data/repo/update_profile_image_repo.dart';
import 'package:meta/meta.dart';

part 'update_profile_image_state.dart';

class UpdateProfileImageCubit extends Cubit<UpdateProfileImageState> {
  UpdateProfileImageCubit(this.updateProfileImageRepo)
      : super(UpdateProfileImageInitial());
  final UpdateProfileImageRepo updateProfileImageRepo;
  Future<void> updateProfileImage({
    required File imageFile,
  }) async {
    emit(UpdateProfileImageLoading());
    final result =
        await updateProfileImageRepo.updateProfileImage(imageFile: imageFile);
    if (isClosed) return;
    result.fold(
      (l) => emit(UpdateProfileImageFailure(errMessage: l.errMesage)),
      (r) {
        updateUserProfileImage(profileImage: r.profileImage);
        emit(UpdateProfileImageSuccess(userInformation: r));
      },
    );
  }
}
