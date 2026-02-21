import 'package:dartz/dartz.dart';
import '../../../test_values.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'today_apod_repository_impl_test.mocks.dart';
import 'package:flutter_astronomy_picture_project/core/failure.dart';
import 'package:flutter_astronomy_picture_project/data/repositores/today_apod/today_apod_repository_impl.dart';
import 'package:flutter_astronomy_picture_project/domain/entities/apod.dart';

//@GenerateNiceMocks([MockSpec<TodayApodDataSource>(), MockSpec<NetworkInfo>()])
void main() {
  late MockTodayApodDataSource dataSource;
  late MockNetworkInfo networkInfo;
  // ignore: unused_local_variable
  late TodayApodRepositoryImpl repositoryImpl;

  setUp(() {
    dataSource = MockTodayApodDataSource();
    networkInfo = MockNetworkInfo();
    repositoryImpl = TodayApodRepositoryImpl(
      dataSource: dataSource,
      networkInfo: networkInfo,
    );
  });

  group('fection FetchTodayApod', () {
    test(
      'Deve retornar uma entidade Apod no lado direito do Either.',
      () async {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.fecthTodayApod()).thenAnswer((_) async => tApodModel());

        final result = await repositoryImpl.fetchTodayApod();
        expect(result, Right<Failure, Apod>(tApod()));
      },
    );
    test(
      'Deve retornar uma Failure no lado esquerdo do Either vindo de datasource.',
      () async {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.fecthTodayApod()).thenThrow(ApiFailure());

        final result = await repositoryImpl.fetchTodayApod();
        expect(result, Left<Failure, Apod>(ApiFailure()));
      },
    );
    test(
      'Deve retornar uma Failure no lado esquerdo do tipo NoConnection.',
      () async {
        when(networkInfo.isConnected).thenAnswer((_) async => false);

        verifyNever(dataSource.fecthTodayApod());

        final result = await repositoryImpl.fetchTodayApod();
        expect(result, Left<Failure, Apod>(NoConnection()));
      },
    );
  });
}
