import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success.dart';
import 'package:astronomy_picture/domain/repositores/bookmark/bookmark_repository.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:dartz/dartz.dart';

class RemoveSaveApod extends UseCase<ApodRemoved, String> {
  final BookmarkRepository repository;

  RemoveSaveApod({required this.repository});

  @override
  Future<Either<Failure, ApodRemoved>> call(String parameter) async {
    return await repository.removeSaveApod(parameter);
  }
}
