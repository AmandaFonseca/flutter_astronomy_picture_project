import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success.dart';
import 'package:astronomy_picture/data/datasources/bookmark/bookmark_datasource_local/bookmark_apod_data_source.dart';
import 'package:astronomy_picture/data/datasources/bookmark/bookmark_datasource_local/bookmark_apod_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../test_values.dart';
import '../search/search_local_data_source_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  late MockSharedPreferences sharedPreferences;
  late BookmarkApodDataSource localDataSource;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    localDataSource = BookmarkApodDataSourceImpl(
      preferences: sharedPreferences,
    );
  });

  group("Function saveApod", () {
    test("Should return an ApodSaved", () async {
      when(sharedPreferences.setString(any, any)).thenAnswer((_) async => true);

      final result = await localDataSource.saveApod(tApodModel());

      expect(result, ApodSaved());
    });

    test(
      "Should throw a SaveDataFailure when the sharedPreferences failure",
      () async {
        when(
          sharedPreferences.setString(any, any),
        ).thenThrow(Exception("Exception"));

        expect(
          () => localDataSource.saveApod(tApodModel()),
          throwsA(isA<AccessLocalDataFailure>()),
        );
      },
    );
  });

  group("Function removeSaveApod", () {
    test("Deve retornar um ApodSaveRemoved", () async {
      when(sharedPreferences.remove(any)).thenAnswer((_) async => true);

      final result = await localDataSource.removeSaveApod("2004-09-27");

      expect(result, ApodRemoved());
    });

    test(
      "Deve lançar uma exceção RemoveDataFailure quando ocorrer uma falha nas preferências compartilhadas.",
      () async {
        when(sharedPreferences.remove(any)).thenThrow(Exception("Exception"));

        expect(
          () => localDataSource.removeSaveApod("2004-09-27"),
          throwsA(isA<AccessLocalDataFailure>()),
        );
      },
    );
  });
}
