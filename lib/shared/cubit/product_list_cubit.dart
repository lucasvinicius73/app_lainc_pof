import 'package:app_lainc_pof/shared/models/product_model.dart';
import 'package:app_lainc_pof/shared/repositories/remote/remote_product_repository.dart';
import 'package:app_lainc_pof/shared/repositories/request_state.dart';
import 'package:app_lainc_pof/states/product_list_state.dart';
import 'package:bloc/bloc.dart';

class ProductListCubit extends Cubit<ProductListState> {
  final RemoteProductRepository productRepository;
  ProductListCubit(this.productRepository) : super(EmptyProductListState());

  Future<void> fechProducts() async {
    emit(LoadingProductListState());
    List<Product> products = [];
    final resultProducts = await productRepository.fetch();

    resultProducts.fold((onSuccess) {
      products = onSuccess;
      if (products.isNotEmpty) {
        emit(GettedProductListState(products: products));
      } else {
        emit(EmptyProductListState());
      }
    }, (onFailure) {
      if (onFailure is Error) {
        emit(FailureProductListState(message: onFailure.message));
      }
    });
  }
}
