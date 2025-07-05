part of 'global_search_cubit.dart';

@immutable
sealed class GlobalSearchState {}

final class GlobalSearchInitial extends GlobalSearchState {}

final class GlobalSearchSuccess extends GlobalSearchState {
  final List<MediaModel> mediaList;
  GlobalSearchSuccess({required this.mediaList});
}

final class GlobalSearchFailure extends GlobalSearchState {
  final String message;
  GlobalSearchFailure({required this.message});
}
