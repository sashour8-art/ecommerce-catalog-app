import 'package:equatable/equatable.dart';
import '../../../../models/category_model.dart';
import '../../../../models/product_model.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object?> get props => [];
}

class StoreInitial extends StoreState {}

// ----------------- Categories -----------------
class CategoriesLoading extends StoreState {}

class CategoriesLoaded extends StoreState {
  final List<CategoryModel> categories;

  const CategoriesLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategoriesError extends StoreState {
  final String message;

  const CategoriesError(this.message);

  @override
  List<Object?> get props => [message];
}

// ----------------- Products -----------------
class ProductsLoading extends StoreState {}

class ProductsLoaded extends StoreState {
  final List<ProductModel> products;
  final String categorySlug;

  const ProductsLoaded(this.products, this.categorySlug);

  @override
  List<Object?> get props => [products, categorySlug];
}

class ProductsError extends StoreState {
  final String message;

  const ProductsError(this.message);

  @override
  List<Object?> get props => [message];
}