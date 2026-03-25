import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositores/bookmark/bookmark_repository.dart';
import 'package:dartz/dartz.dart';

class BookmarkApodRepositoryImpl implements BookmarkRepository {
  @override
  Future<Either<Failure, bool>> apodIsSave(String apodDate) {
    // TODO: implement apodIsSave
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Apod>>> fetchAllApodsSaved() {
    // TODO: implement fetchAllApodsSaved
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ApodRemoved>> removeSaveApod(String apodDate) {
    // TODO: implement removeSaveApod
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ApodSaved>> saveApod(Apod apod) {
    // TODO: implement saveApod
    throw UnimplementedError();
  }
}
