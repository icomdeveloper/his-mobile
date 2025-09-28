import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:his/features/authentication/data/models/user_data/user_information.dart';
import 'package:his/features/profile/data/repo/edit_profile_repo.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.editProfileRepo) : super(EditProfileInitial());
  final EditProfileRepo editProfileRepo;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController countryOfPractice = TextEditingController();
  TextEditingController academicTitle = TextEditingController();
  TextEditingController jobDescription = TextEditingController();
  TextEditingController institution = TextEditingController();
  TextEditingController department = TextEditingController();
  String? yearOfGraduation;
  TextEditingController countryOfGraduation = TextEditingController();
  Future<void> editProfile() async {
    emit(EditProfileLoading());
    final UserInformation userInfo = UserInformation(
      name: nameController.text,
      phone: phoneController.text,
      academicTitle: academicTitle.text,
      jobDescription: jobDescription.text,
      yearOfGraduation: yearOfGraduation,
      countryOfPractices: countryOfPractice.text,
      institution: institution.text,
      department: department.text,
      countryOfGraduation: countryOfGraduation.text,
    );
    final result = await editProfileRepo.editProfile(userUpdates: userInfo);
    if (isClosed) return;
    result.fold((l) => emit(EditProfileFailure(errMessage: l.errMesage)),
        (r) => emit(EditProfileSuccess(name: r['name'], phone: r['phone'])));
  }

  // void setYearOfGraduation(DateTime dateTime) {
  //   yearOfGraduation = dateTime;
  //   emit(YearUpdated());
  // }
}
