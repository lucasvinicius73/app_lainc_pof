import 'dart:convert';
import 'dart:io';

import 'package:app_lainc_pof/shared/models/product_model.dart';
import 'package:app_lainc_pof/shared/repositories/remote/api_config.dart';
import 'package:app_lainc_pof/shared/repositories/repository.dart';
import 'package:app_lainc_pof/shared/repositories/request_state.dart';
import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

class RemoteProductRepository implements Repository<Product> {
  final Dio dio;
  RemoteProductRepository(this.dio);

  String url = ApiConfig.baseUrl;
  String token = ApiConfig.temporaryToken;

  @override
  AsyncResult<List<Product>, RequestState> fetch() async {
    try {
      final response = await dio.get("$url/products",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        List decodeResponse = response.data;
        final products =
            decodeResponse.map((json) => Product.fromJson(json)).toList();
        return Success(products);
      } else if (response.statusCode == 500) {
        return Failure(Error(message: "Status 500: Erro interno na API "));
      } else if (response.statusCode == 401) {
        return Failure(Error(message: "Autenticação Expirada"));
      } else if (response.statusCode == 400) {
        return Failure(Error(message: "Dados não cadastrados"));
      } else if (response.statusCode == 403) {
        return Failure(Error(
            message:
                "Acesso não autorizado, permissão de Administrador necessária"));
      } else {
        print("Caiu no Erro Desconhecido Status: ${response.statusCode} Body: ${response.data}");

        return Failure(Error(message: "Erro inesperado Status: ${response.statusCode}"));
      }
    } on DioException catch (e) {
      print("Caiu no DioExeception");
      if (e.type == DioExceptionType.connectionError &&
          e.error is SocketException) {
        return Failure(Error(message: "Sem conexão com a internet"));
      } else {
        return Failure(Error(message: "Erro de rede: ${e.message}"));
      }
    } catch (e) {
      print("Caiu no Erro geral: $e");

      return Failure(Error(message: "Erro desconhecido: $e"));
    }
  }

  @override
  Future<List<Product>> post(List<Product> products) async {
    // TODO: implement post
    throw UnimplementedError();
  }
}
