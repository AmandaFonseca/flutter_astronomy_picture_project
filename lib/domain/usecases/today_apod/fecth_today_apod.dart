import 'package:dartz/dartz.dart';
import 'package:flutter_astronomy_picture_project/core/failure.dart';
import 'package:flutter_astronomy_picture_project/domain/entities/apod.dart';
import 'package:flutter_astronomy_picture_project/domain/usecases/core/usecase.dart';
import 'package:flutter_astronomy_picture_project/domain/repositores/today_apod/today_apod_repository.dart';

class FetchApodToday extends UseCase<Apod, NoParameter> {
  final TodayApodRepository todayApodRepository;

  FetchApodToday(
    this.todayApodRepository, {
    required TodayApodRepository repository,
  });

  @override
  Future<Either<Failure, Apod>> call(NoParameter parameter) async {
    return await todayApodRepository.fetchTodayApod();
  }
}
