import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositores/today_apod/today_apod_repository.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:astronomy_picture/domain/usecases/today_apod/fetch_apod_today.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'fetch_apod_today_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TodayApodRepository>()])
void main() {
  late MockTodayApodRepository mockTodayApodRepository;
  late FetchApodToday usecase;

  setUp(() {
    mockTodayApodRepository = MockTodayApodRepository();
    usecase = FetchApodToday(todayApodRepository: mockTodayApodRepository);
  });

  test("Deve retornar um entidade Apod no lado direito do Either", () async {
    // cenário
    when(
      mockTodayApodRepository.fetchTodayApod(),
    ).thenAnswer((_) async => Right<Failure, Apod>(tApod()));
    // ação
    final result = await usecase(NoParameter());
    // esperado
    expect(result, Right<Failure, Apod>(tApod()));
  });

  // retorna falha
  test("Deve retornar um Failure no lado esquerdo do Either", () async {
    // cenário
    when(
      mockTodayApodRepository.fetchTodayApod(),
    ).thenAnswer((_) async => Left<Failure, Apod>(tNoConnection()));
    // ação
    final result = await usecase(NoParameter());
    // esperado
    expect(result, Left<Failure, Apod>(tNoConnection()));
  });
}
