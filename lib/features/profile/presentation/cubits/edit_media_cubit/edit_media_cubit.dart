import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:his/features/profile/data/model/edit_media_model.dart';
import 'package:his/features/profile/data/repo/edit_media_repo.dart';
import 'package:html_editor_enhanced/html_editor.dart';

part 'edit_media_state.dart';

class EditMediaCubit extends Cubit<EditMediaState> {
  EditMediaCubit(this.editMediaRepo) : super(EditMediaInitial());
  final EditMediaRepo editMediaRepo;
  File? video, pdf, thumbnailImage, image;
  TextEditingController titleController = TextEditingController();
  HtmlEditorController descriptionController = HtmlEditorController();

  Future<void> editMedia(
      {required int mediaId,
      required int userId,
      required String year,
      required String month}) async {
    emit(EditMediaLoading());
    EditMediaModel editMediaModel = EditMediaModel(
        mediaId: mediaId,
        userId: userId,
        year: year,
        month: month,
        title: titleController.text,
        description: await descriptionController.getText(),
        videoFile: video,
        pdfFile: pdf,
        thumbnailFile: thumbnailImage,
        imageFile: image);
    final result =
        await editMediaRepo.editMedia(editMediaModel: editMediaModel);
    result.fold((l) => emit(EditMediaFailure(errMessage: l.errMesage)),
        (r) => emit(EditMediaSuccess(message: r)));
  }
}
