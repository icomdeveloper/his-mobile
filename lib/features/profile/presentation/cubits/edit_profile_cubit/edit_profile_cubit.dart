import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:his/features/profile/data/repo/edit_profile_repo.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.editProfileRepo) : super(EditProfileInitial());
  final EditProfileRepo editProfileRepo;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  Future<void> editProfile() async {
    emit(EditProfileLoading());
    final result = await editProfileRepo.editProfile(
        name: nameController.text, phone: phoneController.text);
    if (isClosed) return;
    result.fold((l) => emit(EditProfileFailure(errMessage: l.errMesage)),
        (r) => emit(EditProfileSuccess(name: r['name'], phone: r['phone'])));
  }
}
