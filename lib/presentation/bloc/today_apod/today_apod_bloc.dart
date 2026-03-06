import 'dart:async';

import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:astronomy_picture/domain/usecases/today_apod/fetch_apod_today.dart';
import 'package:equatable/equatable.dart';

part 'today_apod_event.dart';
part 'today_apod_state.dart';

class TodayApodBloc {
  final FetchApodToday usecase;
  TodayApodBloc({required this.usecase}) {
    _inputController.stream.listen(_blocEventController);
  }

  final StreamController<TodayApodEvent> _inputController =
      StreamController<TodayApodEvent>();
  final StreamController<TodayApodState> _outputController =
      StreamController<TodayApodState>();

  Sink<TodayApodEvent> get input => _inputController.sink;
  Stream<TodayApodState> get stream => _outputController.stream;

  void _blocEventController(TodayApodEvent event) {
    _outputController.add(LoadingTodayApodState());

    if (event is FecthTodayApodEvent) {
      usecase(NoParameter()).then(
        (value) => value.fold(
          (failure) =>
              _outputController.add(ErrorTodayApodState(NoConnection().msg)),
          (apod) => _outputController.add(SucessTodayApodState(apod)),
        ),
      );
    }
  }

  void close() {
    _inputController.close();
    _outputController.close();
  }
}
