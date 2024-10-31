import 'dart:convert';

import 'package:app_lainc_pof/shared/cubit/product_list_cubit.dart';
import 'package:app_lainc_pof/shared/models/product_model.dart';
import 'package:app_lainc_pof/shared/repositories/remote/remote_product_repository.dart';
import 'package:app_lainc_pof/shared/repositories/repository.dart';
import 'package:app_lainc_pof/shared/repositories/request_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

class DioMock extends Mock implements Dio {}

class ResponseMock extends Mock implements Response {}

void main() {
  final Dio dio = DioMock();
  final Response response = ResponseMock();
  final Repository productRepository = RemoteProductRepository(dio);

  void mockDioSuccess(List<dynamic> data) {
    when(() => dio.get(any(), options: any(named: "options"))).thenAnswer(
        (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: data,
            statusCode: 200));
  }

  void mockDioError(int statusCode) {
    when(() => dio.get(any(), options: any(named: "options")))
        .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: statusCode,
            ));
  }

  group(
    "Remote Repository Test",
    () {
      test(
        "Must return list of products when status 200 is obtained",
        () async {
          mockDioSuccess(productsJson);
          var result = await productRepository.fetch();

          result.fold(
            (success) => expect(success, expectedProducts),
            (failure) => fail("Esperado sucesso, mas obteve erro: $failure"),
          );

          expect(result.isSuccess(), true);
        },
      );
      test(
        "Must return error when status 400 is obtained",
        () async {
          mockDioError(400);

          var result = await productRepository.fetch();

          RequestState requestState = Loading();
          result.fold(
            (success) => fail("Espera Erro, mas teve Sucesso"),
            (failure) => requestState = failure,
          );

          expect(requestState, isA<Error>().having((e)=> e.message, "message", contains("Dados não cadastrados")));
        },
      );
    },
  );
}

const productsJson = [
  {
    "code": "90403",
    "name": "PACOTE COM TELEFONE FIXO, CELULAR E INTERNET",
    "category": "9",
    "author": "Livio"
  },
  {
    "code": "90402",
    "name": "PACOTE COM TELEFONE FIXO E INTERNET",
    "category": "9",
    "author": "Livio"
  },
  {
    "code": "90401",
    "name": "PACOTE COM CELULAR E INTERNET",
    "category": "9",
    "author": "Livio"
  },
  {
    "code": "90302",
    "name": "CONTA DE TELEFONIA CELULAR (VOZ+INTERNET)",
    "category": "9",
    "author": "Livio"
  },
];

final List<Product> expectedProducts = [
  Product(
      code: "90403",
      name: "PACOTE COM TELEFONE FIXO, CELULAR E INTERNET",
      category: "9"),
  Product(
      code: "90402",
      name: "PACOTE COM TELEFONE FIXO E INTERNET",
      category: "9"),
  Product(code: "90401", name: "PACOTE COM CELULAR E INTERNET", category: "9"),
  Product(
      code: "90302",
      name: "CONTA DE TELEFONIA CELULAR (VOZ+INTERNET)",
      category: "9"),
];
