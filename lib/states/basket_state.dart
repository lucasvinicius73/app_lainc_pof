import 'package:app_lainc_pof/shared/models/product_model.dart';

sealed class BasketState {}

class LoadingBasketState implements BasketState {}

class GetterdBasketState implements BasketState {
  final List<Product> products;

  GetterdBasketState({required this.products});
}

class EmptyBasketState implements BasketState {}

class FailureBasketState implements BasketState {
  final String message;
  FailureBasketState({required this.message});
}
