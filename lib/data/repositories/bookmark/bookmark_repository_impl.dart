import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success.dart';
import 'package:astronomy_picture/data/datasources/bookmark/bookmark_datasource_local/bookmark_apod_data_source.dart';
import 'package:astronomy_picture/data/models/apod_model.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositores/bookmark/bookmark_repository.dart';
import 'package:dartz/dartz.dart';

class BookmarkApodRepositoryImpl implements BookmarkRepository {
  final BookmarkApodDataSource bookmarkApodDataSource;

  BookmarkApodRepositoryImpl({required this.bookmarkApodDataSource});

  @override
  Future<Either<Failure, bool>> apodIsSave(String apodDate) {
    return _callDataSource(() => bookmarkApodDataSource.apodIsSave(apodDate));
  }

  @override
  Future<Either<Failure, List<Apod>>> fetchAllApodsSaved() {
    return _callDataSource(() => bookmarkApodDataSource.getAllApodSave());
  }

  @override
  Future<Either<Failure, ApodRemoved>> removeSaveApod(String apodDate) {
    return _callDataSource(
      () => bookmarkApodDataSource.removeSaveApod(apodDate),
    );
  }

  @override
  Future<Either<Failure, ApodSaved>> saveApod(Apod apod) {
    return _callDataSource(
      () => bookmarkApodDataSource.saveApod(ApodModel.fromEntity(apod)),
    );
  }

  Future<Either<Failure, A>> _callDataSource<A>(
    Future<A> Function() func,
  ) async {
    try {
      return Right(await func());
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
