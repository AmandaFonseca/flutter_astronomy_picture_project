import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/repositores/bookmark/bookmark_repository.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:dartz/dartz.dart';

class ApodIsSave extends UseCase<bool, String> {
  final BookmarkRepository repository;
  ApodIsSave({required this.repository});

  @override
  Future<Either<Failure, bool>> call(String parameter) async {
    return await repository.apodIsSave(parameter);
  }
}
