part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesFailure extends CategoriesState {
  final String message;
  CategoriesFailure({required this.message});
}

final class CategoriesSuccess extends CategoriesState {
  final List<Categories> categories;
  CategoriesSuccess({required this.categories});
}
