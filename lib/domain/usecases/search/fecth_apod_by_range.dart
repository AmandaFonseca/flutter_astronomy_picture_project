import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositores/search/search_repository.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:dartz/dartz.dart';

class FetchApodByRange extends UseCase<List<Apod>, String> {
  final SearchRepository repository;
  FetchApodByRange({required this.repository});

  @override
  Future<Either<Failure, List<Apod>>> call(String parameter) async {
    final query = toStandardQuery(parameter).fold((l) => l, (r) => r);
    if (query is Map) {
      return await repository.fetchApodByDateRange(
        query['start'],
        query['end'],
      );
    } else {
      return Left(query as Failure);
    }
  }

  Either<Failure, Map<String, dynamic>> toStandardQuery(String query) {
    if (query.length == 21) {
      final list = query.split("/");
      if (list.length == 2) {
        try {
          DateTime.tryParse(list[0]);
          DateTime.tryParse(list[1]);
          return Right({'start': list[0], 'end': list[1]});
        } catch (e) {
          Left(ConvertFailure());
        }
      }
    }
    if (query.length == 10) {
      try {
        DateTime.tryParse(query);
        return Right({'start': query, 'end': query});
      } catch (e) {
        return Left(ConvertFailure());
      }
    } else {
      return Left(ConvertFailure());
    }
  }
}
