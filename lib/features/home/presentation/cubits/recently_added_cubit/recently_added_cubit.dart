import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/home/data/repo/recently_added_repo.dart';
import 'package:meta/meta.dart';

part 'recently_added_state.dart';

class RecentlyAddedCubit extends Cubit<RecentlyAddedState> {
  RecentlyAddedCubit(this.recentlyAddedRepo) : super(RecentlyAddedInitial());
  final RecentlyAddedRepo recentlyAddedRepo;

  Future<void> getRecentlyAddedVideos({required BuildContext context}) async {
    emit(RecentlyAddedLoading());
    final result =
        await recentlyAddedRepo.getRecentlyAddedVideos(context: context);
    if (isClosed) return;

    result.fold(
        (error) => emit(RecentlyAddedFailure(errMessage: error.errMesage)),
        (mediaList) => emit(RecentlyAddedSuccess(mediaList: mediaList)));
  }
}
