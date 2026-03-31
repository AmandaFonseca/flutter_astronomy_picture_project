import 'dart:async';

import 'package:astronomy_picture/domain/usecases/fetch_apods/fetch_apods.dart';

import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:equatable/equatable.dart';

part 'fetch_apods_bloc_event.dart';
part 'fetch_apods_bloc_state.dart';

class FetchApodsBloc {
  FetchApods fetchApods;

  FetchApodsBloc({required this.fetchApods}) {
    _inputController.stream.listen(_mapEventToState);
  }

  final StreamController<FetchApodsEvent> _inputController =
      StreamController<FetchApodsEvent>();
  final StreamController<FetchApodsState> _outputController =
      StreamController();

  Sink<FetchApodsEvent> get input => _inputController.sink;
  Stream<FetchApodsState> get stream => _outputController.stream;

  void _mapEventToState(FetchApodsEvent event) {
    _outputController.add(LoadingFetchApodsState());

    if (event is MakeFetchApodsEvent) {
      fetchApods(NoParameter()).then(
        (value) => value.fold(
          (failure) =>
              _outputController.add(ErrorFetchApodsState(msg: failure.msg)),
          (success) =>
              _outputController.add(SuccessListFetchApods(list: success)),
        ),
      );
    }
  }
}
