import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/success.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';

abstract class BookmarkRepository {
  Future<Either<Failure, ApodSaved>> saveApod(Apod apod);
  Future<Either<Failure, ApodRemoved>> removeSaveApod(String apodDate);
  Future<Either<Failure, bool>> apodIsSave(String apodDate);
  Future<Either<Failure, List<Apod>>> fetchAllApodsSaved();
}
