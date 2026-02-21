import 'package:dartz/dartz.dart';
import 'package:flutter_astronomy_picture_project/core/failure.dart';
import 'package:flutter_astronomy_picture_project/domain/entities/apod.dart';

abstract class TodayApodRepository {
  Future<Either<Failure, Apod>> fetchTodayApod();
}
