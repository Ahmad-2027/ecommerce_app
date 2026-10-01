part of 'category_cubit.dart';

sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoriesLoading extends CategoryState {}

final class CategoriesLoaded extends CategoryState {
  final List<CategoryModel> categores;
  CategoriesLoaded({required this.categores});
}

final class CategoryLoadingError extends CategoryState {
  final String message;
  CategoryLoadingError(this.message);
}
