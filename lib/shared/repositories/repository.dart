import 'package:app_lainc_pof/shared/models/product_model.dart';

abstract class Repository<T> {
  Future<List<T>> fetch();
  Future<List<T>> post(List<T> itens);
}
