import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositores/search/fetch_apod_by_date_range.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl implements FetchApodByDateRange {
  @override
  Future<Either<Failure, List<String>>> fetchApodSearchHistory() {
    // TODO: implement fetchApodSearchHistory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Apod>>> fetchApodByDateRange(
    String startDate,
    String endDate,
  ) {
    // TODO: implement fetchApodByDateRange
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<String>>> updateApodDateRange(
    List<String> historyList,
  ) {
    // TODO: implement updateApodDateRange
    throw UnimplementedError();
  }
}
