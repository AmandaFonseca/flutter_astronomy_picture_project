import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/network/network_info.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_data_source_remote/today_apod_data_source.dart';
import 'package:astronomy_picture/data/repositories/today_apod/today_apod_repository_impl.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'today_apod_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TodayApodDataSource>(), MockSpec<NetworkInfo>()])
void main() {
  late MockTodayApodDataSource dataSource;
  late MockNetworkInfo networkInfo;
  late TodayApodRepositoryImpl repository;

  setUp(() {
    dataSource = MockTodayApodDataSource();
    networkInfo = MockNetworkInfo();
    repository = TodayApodRepositoryImpl(
      dataSource: dataSource,
      networkInfo: networkInfo,
    );
  });

  group('function fetchTodayApod', () {
    test("Deve retornar uma entidade Apod no lado direito do Either", () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(dataSource.fecthTodayApod()).thenAnswer((_) async => tApodModel());

      final result = await repository.fetchTodayApod();
      expect(result, Right<Failure, Apod>(tApodModel()));
    });

    test(
      "Deve retornar uma Failure no lado esquerdo do Either vindo do datasource",
      () async {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.fecthTodayApod()).thenThrow(ApiFailure());

        final result = await repository.fetchTodayApod();
        expect(result, Left<Failure, Apod>(ApiFailure()));
      },
    );

    // sem internet = falhar
    test(
      "Deve retornar uma Failure no lado esquerdo do tipo NoConnection",
      () async {
        when(networkInfo.isConnected).thenAnswer((_) async => false);

        final result = await repository.fetchTodayApod();

        verifyNever(dataSource.fecthTodayApod());
        expect(result, Left<Failure, Apod>(NoConnection()));
      },
    );
  });
}
