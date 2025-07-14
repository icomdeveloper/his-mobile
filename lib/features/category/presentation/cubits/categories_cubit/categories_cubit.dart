import 'package:bloc/bloc.dart';
import 'package:his/features/category/data/model/categories/categories.dart';
import 'package:his/features/category/data/repo/categories_repo.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.categoriesRepo) : super(CategoriesInitial());
  final CategoriesRepo categoriesRepo;

  Future<void> getCategories() async {
    emit((CategoriesLoading()));
    final result = await categoriesRepo.getCategories();
    if (isClosed) return;
    result.fold((l) => emit(CategoriesFailure(message: l.errMesage)),
        (r) => emit(CategoriesSuccess(categories: r)));
  }
}
