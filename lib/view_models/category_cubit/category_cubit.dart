import 'package:ecommerce_app/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/category_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  final homeServices = HomeServicesImp();
  Future<void> getCategories() async {
    try {
      emit(CategoriesLoading());
      final result = await homeServices.fetchCategories();
      emit(CategoriesLoaded(categores: result));
    } catch (e) {
      emit(CategoryLoadingError(e.toString()));
    }
  }
}
