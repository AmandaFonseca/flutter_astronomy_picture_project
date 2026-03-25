import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success.dart';
import 'package:astronomy_picture/domain/usecases/bookmark/remove_save_apod.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'apod_is_save_test.mocks.dart';

void main() {
  late MockBookmarkRepository repository;
  late RemoveSaveApod usecase;

  setUp(() {
    repository = MockBookmarkRepository();
    usecase = RemoveSaveApod(repository: repository);
  });

  test('Deve retornar um Success no lado direito de Either.', () async {
    when(
      repository.removeSaveApod(any),
    ).thenAnswer((_) async => Right<Failure, ApodRemoved>(ApodRemoved()));

    final result = await usecase("date");

    expect(result, Right<Failure, ApodRemoved>(ApodRemoved()));
  });

  test(
    'Deve retornar uma falha no lado esquerdo de qualquer um dos dois.',
    () async {
      when(repository.removeSaveApod(any)).thenAnswer(
        (_) async => Left<Failure, ApodRemoved>(AccessLocalDataFailure()),
      );

      final result = await usecase("date");

      expect(result, Left<Failure, ApodRemoved>(AccessLocalDataFailure()));
    },
  );
}
