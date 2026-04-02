import 'dart:io';

import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_data_source_remote/today_apod_data_source_impl.dart';
import 'package:astronomy_picture/data/repositories/core/translator_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../mocks/mocks.mocks.dart';
import './today_apod_data_source_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TranslationService>()])
void main() {
  late MockClient client;
  late MockTranslationService translator;
  late TodayApodDataSourceImpl dataSource;

  setUp(() {
    client = MockClient();
    translator = MockTranslationService();

    when(translator.translate(any)).thenAnswer((_) async => "translated text");

    dataSource = TodayApodDataSourceImpl(
      client: client,
      translator: translator,
    );
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
