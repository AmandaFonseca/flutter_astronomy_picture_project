import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositores/search/search_repository.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl implements SearchRepository {
  @override
  Future<Either<Failure, List<String>>> fetchApodSearchHistory() {
    // TODO: implement fetchApodSearchHistory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Apod>>> getApodDateRange(
    String startDate,
    String endDate,
  ) {
    // TODO: implement getApodDateRange
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
