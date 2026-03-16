import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/repositores/search/fetch_apod_by_date_range.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:dartz/dartz.dart';

class FetchApodSearchHistory extends UseCase<List<String>, NoParameter> {
  final FetchApodByDateRange repository;
  FetchApodSearchHistory({required this.repository});

  @override
  Future<Either<Failure, List<String>>> call(NoParameter parameter) {
    return repository.fetchApodSearchHistory();
  }
}
