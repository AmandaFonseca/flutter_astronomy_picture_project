import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositores/today_apod/today_apod_repository.dart';
import 'package:astronomy_picture/domain/usecases/core/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:astronomy_picture/core/failure.dart';

class FetchApodToday extends UseCase<Apod, NoParameter> {
  final TodayApodRepository todayApodRepository;

  FetchApodToday({required this.todayApodRepository});

  @override
  Future<Either<Failure, Apod>> call(NoParameter parameters) {
    return todayApodRepository.fetchTodayApod();
  }
}
