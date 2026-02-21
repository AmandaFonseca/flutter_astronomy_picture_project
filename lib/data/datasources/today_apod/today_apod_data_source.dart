import 'package:flutter_astronomy_picture_project/data/models/apod_model.dart';

abstract class TodayApodDataSource {
  Future<ApodModel> fecthTodayApod();
}
