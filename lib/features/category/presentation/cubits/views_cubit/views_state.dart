part of 'views_cubit.dart';

@immutable
sealed class ViewsState {}

final class ViewsInitial extends ViewsState {}

final class ViewsSuccess extends ViewsState {
  final int viewsCount;
  ViewsSuccess({required this.viewsCount});
}

final class ViewsFailure extends ViewsState {
  final String message;
  ViewsFailure({required this.message});
}
