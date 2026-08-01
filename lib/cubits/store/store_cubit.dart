import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../repositories/api_service.dart';
import 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  final ApiService _apiService;

  StoreCubit({ApiService? apiService})
      : _apiService = apiService ?? ApiService(),
        super(StoreInitial());

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    try {
      final categories = await _apiService.getCategories();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  Future<void> fetchProductsByCategory(String slug) async {
    emit(ProductsLoading());
    try {
      final products = await _apiService.getProductsByCategory(slug);
      emit(ProductsLoaded(products, slug));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}