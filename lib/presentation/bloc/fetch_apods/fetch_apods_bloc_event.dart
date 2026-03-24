part of 'fetch_apods_bloc.dart';

abstract class FetchApodsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MakeFetchApodsEvent extends FetchApodsEvent {}
