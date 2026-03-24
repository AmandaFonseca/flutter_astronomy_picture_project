import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositores/search/search_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../test_values.dart';
import 'package:astronomy_picture/domain/usecases/search/fecth_apod_by_range.dart';
import 'fetch_apod_by_data_range_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SearchRepository>()])
void main() {
  late MockSearchRepository repository;
  late FetchApodByRange usecase;

  setUp(() {
    repository = MockSearchRepository();
    usecase = FetchApodByRange(repository: repository);
  });

  test('Deve retornar Apod do lado direito dof Either', () async {
    //cenario
    when(
      repository.fetchApodByDateRange(any, any),
    ).thenAnswer((_) async => Right<Failure, List<Apod>>(tListApod()));

    //ação
    final result = await usecase("2022-05-05/2022-05-01");

    //esperado
    result.fold(
      (l) {
        fail("Test failed");
      },
      (r) {
        expect(r, tListApod());
      },
    );
  });

  test('Deve retornar uma falha do lado esquerdo dof Either', () async {
    when(
      repository.fetchApodByDateRange(any, any),
    ).thenAnswer((_) async => Left<Failure, List<Apod>>(NoConnection()));

    final result = await usecase("2022-05-05/2022-05-01");

    expect(result, Left<Failure, Apod>(NoConnection()));
  });

  test(
    'Deve retornar uma Falha no lado Esquerdo de Either para entrada incorreta.',
    () async {
      final result = await usecase("20226-2-05/2026-02-1");

      expect(result, Left<Failure, Apod>(ConvertFailure()));
    },
  );
}
