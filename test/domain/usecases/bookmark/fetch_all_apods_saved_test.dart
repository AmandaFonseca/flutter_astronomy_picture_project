import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/usecases/bookmark/fetch_all_apods_saved.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'apod_is_save_test.mocks.dart';

void main() {
  late MockBookmarkRepository repository;
  late FetchAllApodSave usecase;

  setUp(() {
    repository = MockBookmarkRepository();
    usecase = FetchAllApodSave(repository: repository);
  });

  test(
    'Deve retornar uma lista Apod no lado direito de qualquer um dos dois',
    () async {
      when(
        repository.fetchAllApodsSaved(),
      ).thenAnswer((_) async => Right<Failure, List<Apod>>(tListApod()));

      final result = await usecase(NoParameter());

      result.fold(
        (l) {
          fail("Teste Falha");
        },
        (r) {
          expect(r, tListApod());
        },
      );
    },
  );

  test(
    'Deve retornar uma falha no lado esquerdo de Qqualquer um dos dois.',
    () async {
      when(repository.fetchAllApodsSaved()).thenAnswer(
        (_) async => Left<Failure, List<Apod>>(AccessLocalDataFailure()),
      );

      final result = await usecase(NoParameter());

      expect(result, Left<Failure, List<Apod>>(AccessLocalDataFailure()));
    },
  );
}
