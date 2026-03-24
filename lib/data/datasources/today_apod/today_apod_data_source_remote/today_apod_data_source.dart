import 'package:astronomy_picture/data/models/apod_model.dart';

abstract class TodayApodDataSource {
  Future<ApodModel> fecthTodayApod();
}
