import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/network/network_info.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_data_source_remote/today_apod_data_source.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositores/today_apod/today_apod_repository.dart';
import 'package:dartz/dartz.dart';

class TodayApodRepositoryImpl implements TodayApodRepository {
  final TodayApodDataSource dataSource;
  final NetworkInfo networkInfo;

  TodayApodRepositoryImpl({
    required this.dataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Apod>> fetchTodayApod() async {
    if (await networkInfo.isConnected) {
      try {
        final model = await dataSource.fecthTodayApod();
        return Right(model);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NoConnection());
    }
  }
}
