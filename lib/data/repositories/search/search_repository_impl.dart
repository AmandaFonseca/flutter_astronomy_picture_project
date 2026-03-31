import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/network/network_info.dart';
import 'package:astronomy_picture/data/datasources/seacrh/search_datasource_local/search_local_data_source.dart';
import 'package:astronomy_picture/data/datasources/seacrh/search_datasource_remote/search_remote_data_source_.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositores/search/search_repository.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchLocalDataSource localDataSource;
  final SearchRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Apod>>> fetchApodByDateRange(
    String startDate,
    String endDate,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final apodList = await remoteDataSource.fetchApodByDateRange(
          startDate,
          endDate,
        );
        return Right(apodList);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NoConnection());
    }
  }

  @override
  Future<Either<Failure, List<String>>> fetchSearchHistory() async {
    return _callLocalDataSource(() => localDataSource.fetchSearchHistory());
  }

  @override
  Future<Either<Failure, List<String>>> updateSearchHistory(
    List<String> historyList,
  ) async {
    return await _callLocalDataSource(
      () => localDataSource.updateSearchHistory(historyList),
    );
  }

  Future<Either<Failure, A>> _callLocalDataSource<A>(
    Future<A> Function() func,
  ) async {
    try {
      return Right(await func());
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
