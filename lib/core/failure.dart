import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String get msg;
  @override
  List<Object?> get props => [msg];
}

class NoConnection extends Failure {
  @override
  String get msg => 'Sorry! You not have connection to the internet.';
}

class ApiFailure extends Failure {
  @override
  String get msg => 'Sorry! It was not possible to acess the Server.';
}
