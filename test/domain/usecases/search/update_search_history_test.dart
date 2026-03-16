import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/usecases/search/update_apod_by_history.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'fetch_apod_by_data_range_test.mocks.dart';

void main() {
  late MockFetchApodByDateRange repository;
  late UpdateApodSearchHistory usecase;

  setUp(() {
    repository = MockFetchApodByDateRange();
    usecase = UpdateApodSearchHistory(repository: repository);
  });

  test('Should return a List of String on  Right side of Either', () async {
    when(
      repository.updateApodDateRange(any),
    ).thenAnswer((_) async => Right<Failure, List<String>>(tHistoryList()));

    final result = await usecase(tHistoryList());

    result.fold((l) => fail("Test failed"), (r) => expect(r, tHistoryList()));
  });

  test('Should return an Failure on Left side of Either', () async {
    when(repository.updateApodDateRange(any)).thenAnswer(
      (_) async => Left<Failure, List<String>>(AccessLocalDataFailure()),
    );

    final result = await usecase(tHistoryList());

    expect(result, Left<Failure, List<String>>(AccessLocalDataFailure()));
  });
}
