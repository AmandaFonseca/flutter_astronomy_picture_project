import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/repositores/bookmark/bookmark_repository.dart';
import 'package:astronomy_picture/domain/usecases/bookmark/apod_is_save.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'apod_is_save_test.mocks.dart';

@GenerateNiceMocks([MockSpec<BookmarkRepository>()])
void main() {
  late MockBookmarkRepository repository;
  late ApodIsSave usecase;

  setUp(() {
    repository = MockBookmarkRepository();
    usecase = ApodIsSave(repository: repository);
  });

  test(
    'Deve retornar um valor booleano no lado direito de `Either`.',
    () async {
      when(
        repository.apodIsSave(any),
      ).thenAnswer((_) async => const Right<Failure, bool>(true));

      final result = await usecase("date");

      expect(result, const Right<Failure, bool>(true));
    },
  );

  test(
    'Deve retornar uma Failure no lado esquerdo de qualquer um dos dois.',
    () async {
      when(
        repository.apodIsSave(any),
      ).thenAnswer((_) async => Left<Failure, bool>(AccessLocalDataFailure()));

      final result = await usecase("date");

      expect(result, Left<Failure, bool>(AccessLocalDataFailure()));
    },
  );
}
