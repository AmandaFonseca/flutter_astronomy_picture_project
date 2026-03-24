part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class FetchByDateRangeSearchEvent extends SearchEvent {
  final String query;

  const FetchByDateRangeSearchEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class FetchHistorySearchEvent extends SearchEvent {}

class UpdateHistorySearchEvent extends SearchEvent {
  final List<String> list;

  const UpdateHistorySearchEvent({required this.list});

  @override
  List<Object> get props => [list];
}
