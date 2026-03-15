import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/repositores/today_apod/search/search_repository.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:dartz/dartz.dart';

class UpdateApodSearchHistory extends UseCase<List<String>, List<String>> {
  final SearchRepository repository;
  UpdateApodSearchHistory({required this.repository});

  @override
  Future<Either<Failure, List<String>>> call(List<String> parameter) {
    throw UnimplementedError();
  }
}
