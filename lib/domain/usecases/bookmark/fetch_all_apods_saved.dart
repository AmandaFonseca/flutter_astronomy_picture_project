import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/repositores/bookmark/bookmark_repository.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';

class FetchAllApodSave extends UseCase<List<Apod>, NoParameter> {
  final BookmarkRepository repository;

  FetchAllApodSave({required this.repository});

  @override
  Future<Either<Failure, List<Apod>>> call(NoParameter parameter) async {
    return await repository.fetchAllApodsSaved();
  }
}
