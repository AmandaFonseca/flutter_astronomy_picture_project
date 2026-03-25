import 'package:equatable/equatable.dart';

class ApodSaved extends Equatable {
  @override
  List<Object?> get props => [];
  String get msg {
    return 'Apod saved';
  }
}

class ApodRemoved extends Equatable {
  @override
  List<Object?> get props => [];
  String get msg => 'Apod removed';
}
