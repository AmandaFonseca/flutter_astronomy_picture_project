import 'dart:io';

import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_data_source_remote/today_apod_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../mocks/mocks.mocks.dart';

void main() {
  late MockClient client;
  late TodayApodDataSourceImpl dataSource;

  setUp(() {
    client = MockClient();
    dataSource = TodayApodDataSourceImpl(client: client);
  });

  group("Function fetchTodayApod", () {
    test(
      "Deve jogar (throw) uma ApiFailure quando a api retornar um valor diferente de 200",
      () async {
        when(
          client.get(any),
        ).thenAnswer((_) async => http.Response('Erro', 500));
        await expectLater(
          dataSource.fecthTodayApod(),
          throwsA(isA<ApiFailure>()),
        );
      },
    );

    test(
      "Deve jogar uma ApiFailure quando a api retornar statusCode diferente de 200",
      () async {
        when(
          client.get(any),
        ).thenAnswer((_) async => http.Response('Erro', 500));
        await expectLater(
          dataSource.fecthTodayApod(),
          throwsA(isA<ApiFailure>()),
        );
      },
    );

    test(
      "Deve jogar uma ApiFailure quando houver um exception no client",
      () async {
        when(client.get(any)).thenThrow(const SocketException("message"));
        await expectLater(
          dataSource.fecthTodayApod(),
          throwsA(isA<ApiFailure>()),
        );
      },
    );
  });
}
