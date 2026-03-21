import 'dart:async';

import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:astronomy_picture/domain/usecases/search/fecth_apod_by_range.dart';
import 'package:astronomy_picture/domain/usecases/search/fetch_search_history.dart';
import 'package:astronomy_picture/domain/usecases/search/update_search_history.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc {
  FetchSearchHistory fetchSearchHistory;
  UpdateSearchHistory updateSearchHistory;
  FetchApodByRange fetchApodByDataRange;

  SearchBloc({
    required this.fetchSearchHistory,
    required this.updateSearchHistory,
    required this.fetchApodByDataRange,
  }) {
    _inputController.stream.listen(_mapEventToState);
  }

  final StreamController<SearchEvent> _inputController =
      StreamController<SearchEvent>();
  final StreamController<SearchState> _outputController =
      StreamController<SearchState>();

  Sink<SearchEvent> get input => _inputController.sink;
  Stream<SearchState> get stream => _outputController.stream;

  void _mapEventToState(SearchEvent event) {
    _outputController.add(LoadingSearchState());

    if (event is FetchHistorySearchEvent) {
      fetchSearchHistory(NoParameter()).then(
        (value) => value.fold(
          (l) => _outputController.add(ErrorSearchState(msg: l.msg)),
          (r) => _outputController.add(SuccessHistorySearchState(list: r)),
        ),
      );
    }

    if (event is UpdateHistorySearchEvent) {
      updateSearchHistory(event.list).then(
        (value) => value.fold(
          (l) => _outputController.add(ErrorSearchState(msg: l.msg)),
          (r) => _outputController.add(SuccessHistorySearchState(list: r)),
        ),
      );
    }

    if (event is FetchByDateRangeSearchEvent) {
      fetchApodByDataRange(event.query).then(
        (value) => value.fold(
          (l) => _outputController.add(ErrorSearchState(msg: l.msg)),
          (r) => _outputController.add(SuccessListSearchState(list: r)),
        ),
      );
    }
  }
}
