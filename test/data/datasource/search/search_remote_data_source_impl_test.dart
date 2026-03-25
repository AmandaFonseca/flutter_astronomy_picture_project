import 'dart:convert';
import 'dart:io';

import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/search/search_datasource_remote/search_remote_data_source_.dart';
import 'package:astronomy_picture/data/datasources/search/search_datasource_remote/search_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/fixtures.dart';
import '../../../mocks/mocks.mocks.dart';
import '../../../test_values.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  late MockClient client;
  late SearchRemoteDataSource remoteDataSource;

  setUpAll(() async {
    dotenv.clean();
    await dotenv.load(fileName: '.env');
  });

  setUp(() {
    client = MockClient();
    remoteDataSource = SearchRemoteDataSourceImpl(client: client);
  });

  group("Function fetchApodByDateRange", () {
    test("Deve retornar uma lista do modelo Apod.", () async {
      when(client.get(any)).thenAnswer(
        (_) async =>
            http.Response.bytes(utf8.encode(fixture('apod_list.json')), 200),
      );

      final result = await remoteDataSource.fetchApodByDateRange(
        '2026-03-05',
        '2026-03-01',
      );

      expect(result, tListApodModel());
    });

    test(
      "Deve lançar uma exceção ApiFailure quando a API não retornar 500.",
      () async {
        when(client.get(any)).thenAnswer(
          (_) async =>
              http.Response.bytes(utf8.encode(fixture('apod_list.json')), 500),
        );

        expect(
          () =>
              remoteDataSource.fetchApodByDateRange('2026-03-05', '2026-03-01'),
          throwsA(isA<ApiFailure>()),
        );
      },
    );

    test(
      "Deve lançar uma exceção ApiFailure quando ocorrer uma exceção.",
      () async {
        when(client.get(any)).thenThrow(const SocketException("message"));

        expect(
          () =>
              remoteDataSource.fetchApodByDateRange('2026-03-05', '2026-03-01'),
          throwsA(isA<ApiFailure>()),
        );
      },
    );
  });
}
