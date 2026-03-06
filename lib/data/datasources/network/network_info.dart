import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker internetConnection;

  NetworkInfoImpl({required this.internetConnection});

  @override
  Future<bool> get isConnected async => internetConnection.hasConnection;
}
