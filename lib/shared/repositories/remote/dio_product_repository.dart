import 'package:app_lainc_pof/shared/models/product_model.dart';
import 'package:app_lainc_pof/shared/repositories/repository.dart';
import 'package:dio/dio.dart';

class RemoteProductRepository implements Repository<Product> {
  final Dio dio;

  RemoteProductRepository(this.dio);

  @override
  Future<List<Product>> fetch() async {
    List<Product> products = [];
    return products;
  }

  @override
  Future<List<Product>> post(List<Product> itens) async{
    // TODO: implement post
    throw UnimplementedError();
  }
}
