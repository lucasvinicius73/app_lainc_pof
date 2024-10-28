import 'package:app_lainc_pof/shared/models/product_model.dart';

sealed class ProductListState {}

class LoadingProductListState implements ProductListState {}

class GetterdProductListState implements ProductListState {
  final List<Product> products;

  GetterdProductListState({required this.products});
}

class EmptyProductListState implements ProductListState {}

class FailureProductListState implements ProductListState {
  final String message;
  FailureProductListState({required this.message});
}
