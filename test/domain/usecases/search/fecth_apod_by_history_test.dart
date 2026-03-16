import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:astronomy_picture/domain/usecases/search/fetch_search_history.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'fetch_apod_by_data_range_test.mocks.dart';

void main() {
  late MockSearchRepository repository;
  late FetchSearchHistory usecase;

  setUp(() {
    repository = MockSearchRepository();
    usecase = FetchSearchHistory(repository: repository);
  });

  test(
    'Deve retornar uma Lista de String no lado direito do Either.',
    () async {
      when(
        repository.fetchSearchHistory(),
      ).thenAnswer((_) async => Right<Failure, List<String>>(tHistoryList()));

      final result = await usecase(NoParameter());

      result.fold(
        (l) => fail("Teste falhou"),
        (r) => expect(r, tHistoryList()),
      );
    },
  );

  test('Deve retornar uma Falha no lado esquerdo do Either.', () async {
    when(repository.fetchSearchHistory()).thenAnswer(
      (_) async => Left<Failure, List<String>>(AccessLocalDataFailure()),
    );

    final result = await usecase(NoParameter());

    expect(result, Left<Failure, List<String>>(AccessLocalDataFailure()));
  });
}
