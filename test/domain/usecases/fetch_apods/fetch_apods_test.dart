import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/repositores/fetch_apods/fetch_apods_repository.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/usecases/fetch_apods/fetch_apods.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'fetch_apods_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FetchApodsRepository>()])
void main() {
  late MockFetchApodsRepository repository;
  late FetchApods usecase;

  setUp(() {
    repository = MockFetchApodsRepository();
    usecase = FetchApods(repository: repository);
  });

  test('Deve retornar uma Apod entity. Lado direito de Qualquer', () async {
    when(
      repository.fetchApods(),
    ).thenAnswer((_) async => Right<Failure, List<Apod>>(tListApod()));

    final result = await usecase(NoParameter());

    result.fold(
      (l) {
        fail("Teste falhou");
      },
      (r) {
        expect(r, tListApod());
      },
    );
  });

  test(
    'Deve retornar uma Failure no lado esquerdo de Qualquer um dos dois.',
    () async {
      when(
        repository.fetchApods(),
      ).thenAnswer((_) async => Left<Failure, List<Apod>>(NoConnection()));

      final result = await usecase(NoParameter());

      expect(result, Left<Failure, Apod>(NoConnection()));
    },
  );
}
