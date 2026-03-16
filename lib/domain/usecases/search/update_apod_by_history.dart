import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/repositores/search/fetch_apod_by_date_range.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:dartz/dartz.dart';

class UpdateApodSearchHistory extends UseCase<List<String>, List<String>> {
  final FetchApodByDateRange repository;
  UpdateApodSearchHistory({required this.repository});

  @override
  Future<Either<Failure, List<String>>> call(List<String> parameter) {
    return repository.updateApodDateRange(parameter);
  }
}
