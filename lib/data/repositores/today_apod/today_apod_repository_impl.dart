import 'package:dartz/dartz.dart';
import 'package:flutter_astronomy_picture_project/core/failure.dart';
import 'package:flutter_astronomy_picture_project/data/datasources/network/network_info.dart';
import 'package:flutter_astronomy_picture_project/data/datasources/today_apod/today_apod_data_source.dart';
import 'package:flutter_astronomy_picture_project/domain/entities/apod.dart';
import 'package:flutter_astronomy_picture_project/domain/repositores/today_apod/today_apod_repository.dart';

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
        return Right(model.toEntity());
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NoConnection());
    }
  }
}
