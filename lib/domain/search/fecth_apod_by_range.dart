import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositores/today_apod/search/search_repository.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:dartz/dartz.dart';

class FetchApodByRange extends UseCase<List<Apod>, String> {
  final SearchRepository repository;
  FetchApodByRange({required this.repository});

  @override
  Future<Either<Failure, List<Apod>>> call(String parameter) {
    throw UnimplementedError();
  }
}
