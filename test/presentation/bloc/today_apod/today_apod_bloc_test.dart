import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/usecases/today_apod/fetch_apod_today.dart';
import 'package:astronomy_picture/presentation/bloc/today_apod/today_apod_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'today_apod_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FetchApodToday>()])
void main() {
  late MockFetchApodToday fetchApodToday;
  late TodayApodBloc bloc;

  setUp(() {
    fetchApodToday = MockFetchApodToday();
    bloc = TodayApodBloc(usecase: fetchApodToday);
  });

  group("usecase - fetchTodayApod", () {
    // sucesso
    test("Deve emitir LoadingApodState and SuccessApodState", () async {
      when(fetchApodToday(any)).thenAnswer((_) async => Right(tApod()));
      bloc.input.add(FecthTodayApodEvent());
      expect(
        bloc.stream,
        emitsInOrder([LoadingTodayApodState(), SucessTodayApodState(tApod())]),
      );
    });
    // falha
    test("Deve emitir LoadingApodState and ErrorApodState", () async {
      when(fetchApodToday(any)).thenAnswer((_) async => left(NoConnection()));
      bloc.input.add(FecthTodayApodEvent());
      expect(
        bloc.stream,
        emitsInOrder([
          LoadingTodayApodState(),
          ErrorTodayApodState(tNoConnection().msg),
        ]),
      );
    });
  });
}
