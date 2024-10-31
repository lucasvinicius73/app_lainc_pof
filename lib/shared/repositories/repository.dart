import 'package:app_lainc_pof/shared/models/product_model.dart';
import 'package:app_lainc_pof/shared/repositories/request_state.dart';
import 'package:result_dart/result_dart.dart';

abstract class Repository<T> {
  AsyncResult<List<T>,RequestState> fetch();
  Future<List<T>> post(List<T> itens);
}
