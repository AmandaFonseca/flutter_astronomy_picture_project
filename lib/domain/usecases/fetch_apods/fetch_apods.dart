import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositores/fetch_apods/fetch_apods_repository.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:dartz/dartz.dart';

class FetchApods extends UseCase<List<Apod>, NoParameter> {
  final FetchApodsRepository repository;
  FetchApods({required this.repository});

  @override
  Future<Either<Failure, List<Apod>>> call(NoParameter parameters) async {
    return repository.fetchApods();
  }
}
