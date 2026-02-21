import 'package:flutter_astronomy_picture_project/data/datasources/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as client;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import './network_info_test.mocks.dart';

@GenerateNiceMocks([MockSpec<InternetConnectionChecker>()])
void main() {
  late MockInternetConnectionChecker internetConnectionChecker;
  late NetworkInfoImpl networkInfoImpl;

  setUp(() {
    internetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(
      internetConnectionChecker: internetConnectionChecker,
    );
  });

  test('Deve retornar um true se houver Conexão.', () async {
    when(internetConnectionChecker.hasConnection).thenAnswer((_) async => true);

    final result = await networkInfoImpl.isConnected;
    expect(result, true);
  });
  test('Deve retornar um false se não houver Conexão.', () async {
    when(
      internetConnectionChecker.hasConnection,
    ).thenAnswer((_) async => false);

    final result = await networkInfoImpl.isConnected;
    expect(result, false);
  });
}
