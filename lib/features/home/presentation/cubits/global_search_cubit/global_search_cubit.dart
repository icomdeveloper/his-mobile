import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/home/data/repo/global_search_repo.dart';
import 'package:meta/meta.dart';

part 'global_search_state.dart';

class GlobalSearchCubit extends Cubit<GlobalSearchState> {
  GlobalSearchCubit(this.globalSearchRepo) : super(GlobalSearchInitial());
  final GlobalSearchRepo globalSearchRepo;

  Future<void> search({required String query}) async {
    emit(GlobalSearchInitial());
    if (query.isEmpty) {
      emit(GlobalSearchInitial());
      return;
    }
    final result = await globalSearchRepo.search(query: query);
    if (isClosed) return;
    result.fold(
      (failure) => emit(GlobalSearchFailure(message: failure.errMesage)),
      (success) => emit(GlobalSearchMediaSuccess(mediaList: success)),
    );
  }

  Future<void> clearResults() async {
    emit(GlobalSearchInitial());
  }
}
