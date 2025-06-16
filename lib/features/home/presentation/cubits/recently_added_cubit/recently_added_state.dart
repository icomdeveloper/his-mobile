part of 'recently_added_cubit.dart';

@immutable
sealed class RecentlyAddedState {}

final class RecentlyAddedInitial extends RecentlyAddedState {}

final class RecentlyAddedLoading extends RecentlyAddedState {}

final class RecentlyAddedFailure extends RecentlyAddedState {
  final String errMessage;
  RecentlyAddedFailure({required this.errMessage});
}

final class RecentlyAddedSuccess extends RecentlyAddedState {
  final List<MediaModel> mediaList;

  RecentlyAddedSuccess({required this.mediaList});
}
