import 'package:dartz/dartz.dart';
import 'package:flutter_astronomy_picture_project/core/failure.dart';
import 'package:flutter_astronomy_picture_project/domain/entities/apod.dart';
import 'package:flutter_astronomy_picture_project/domain/usecases/core/usecase.dart';
import 'package:flutter_astronomy_picture_project/domain/usecases/today_apod/fecth_today_apod.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_values.dart';
import 'today_apod_repository_test.mocks.dart';

//@GenerateNiceMocks([MockSpec<TodayApodRepository>()])
void main() {
  late MockTodayApodRepository repository;
  late FetchApodToday usecase;
  setUp(() {
    repository = MockTodayApodRepository();
    usecase = FetchApodToday(repository, repository: repository);
  });

  test('Deve retornar um entidade Apod no lado direito do Either', () async {
    when(
      repository.fetchTodayApod(),
    ).thenAnswer((_) async => Right<Failure, Apod>(tApod()));
    final result = await usecase(NoParameter());
    expect(result, Right<Failure, Apod>(tApod()));
  });
  test('Deve retornar um Failure no lado esquerdo do Either', () async {
    when(
      repository.fetchTodayApod(),
    ).thenAnswer((_) async => Left<Failure, Apod>(tNoConnection()));
    final result = await usecase(NoParameter());
    expect(result, Left<Failure, Apod>(tNoConnection()));
  });
}
