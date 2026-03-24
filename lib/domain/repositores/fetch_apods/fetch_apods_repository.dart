import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';

abstract class FetchApodsRepository {
  Future<Either<Failure, List<Apod>>> fetchApods();
}
