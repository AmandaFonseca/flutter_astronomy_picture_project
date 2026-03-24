import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/fetch_apods/fetch_apods_data_source.dart';
import 'package:astronomy_picture/data/datasources/network/network_info.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositores/fetch_apods/fetch_apods_repository.dart';
import 'package:dartz/dartz.dart';

class FetchApodsRepositoryImpl implements FetchApodsRepository {
  FetchApodsDataSource fetchApodsDataSource;
  NetworkInfo networkInfo;
  FetchApodsRepositoryImpl({
    required this.fetchApodsDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Apod>>> fetchApods() async {
    if (await networkInfo.isConnected) {
      try {
        final apod = await fetchApodsDataSource.fetchApods();
        return Right(apod);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NoConnection());
    }
  }
}
