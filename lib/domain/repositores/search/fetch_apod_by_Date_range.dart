// ignore: file_names
import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';

abstract class FetchApodByDateRange {
  Future<Either<Failure, List<Apod>>> fetchApodByDateRange(
    String startDate,
    String endDate,
  );
  Future<Either<Failure, List<String>>> updateApodDateRange(
    List<String> historyList,
  );
  Future<Either<Failure, List<String>>> fetchApodSearchHistory();
}
