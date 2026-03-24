import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/usecases/fetch_apods/fetch_apods.dart';
import 'package:astronomy_picture/presentation/bloc/fetch_apods/fetch_apods_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'fetch_apods_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FetchApods>()])
void main() {
  late FetchApodsBloc fetchApodsBloc;
  late MockFetchApods fetchApods;

  setUp(() {
    fetchApods = MockFetchApods();
    fetchApodsBloc = FetchApodsBloc(fetchApods: fetchApods);
  });

  group("usecase - FetchApods", () {
    test("Deve emitir LoadingApodState e SuccessListApodState", () {
      when(fetchApods(any)).thenAnswer((_) async => Right(tListApod()));

      fetchApodsBloc.input.add(MakeFetchApodsEvent());

      expect(
        fetchApodsBloc.stream,
        emitsInOrder([
          LoadingFetchApodsState(),
          SuccessListFetchApods(list: tListApod()),
        ]),
      );
    });

    test("Deve emitir LoadingApodState e ErrorApodState", () {
      when(fetchApods(any)).thenAnswer((_) async => Left(ApiFailure()));

      fetchApodsBloc.input.add(MakeFetchApodsEvent());

      expect(
        fetchApodsBloc.stream,
        emitsInOrder([
          LoadingFetchApodsState(),
          ErrorFetchApodsState(msg: ApiFailure().msg),
        ]),
      );
    });
  });
}
