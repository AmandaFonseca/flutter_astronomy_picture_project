import 'dart:convert';
import 'dart:io';

import 'package:flutter_astronomy_picture_project/core/failure.dart';
import 'package:flutter_astronomy_picture_project/data/datasources/today_apod/today_apod_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../../fixtures/fixtures_test.dart';
import '../../../mocks/mocks_test.mocks.dart';
import '../../../test_values.dart';

void main() {
  late MockClient client;
  late TodayApodDataSourceImpl dataSourceImpl;

  setUp(() {
    client = MockClient();
    dataSourceImpl = TodayApodDataSourceImpl(client: client);
  });

  test('Deve retornar um Apod model', () async {
    when(client.get(any)).thenAnswer(
      (_) async =>
          http.Response.bytes(utf8.encode(fixture('image.response.json')), 200),
    );

    final result = await dataSourceImpl.fecthTodayApod();
    expect(result, tApodModel());
  });
  test(
    'Deve jogar (thrown) um ApiFalure quando a api retornar um valor diferente de 200',
    () async {
      when(client.get(any)).thenAnswer(
        (_) async => http.Response.bytes(
          utf8.encode(fixture('image.response.json')),
          500,
        ),
      );
      expect(() => dataSourceImpl.fecthTodayApod(), throwsA(isA<ApiFailure>()));
    },
  );

  test('Deve jogar (thrown) um ApiFalure quando houver um expection', () async {
    when(client.get(any)).thenThrow(const SocketException("message"));

    expect(() => dataSourceImpl.fecthTodayApod(), throwsA(isA<ApiFailure>()));
  });
}
