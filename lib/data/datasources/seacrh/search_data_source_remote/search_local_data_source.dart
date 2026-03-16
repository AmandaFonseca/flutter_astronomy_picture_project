import 'package:astronomy_picture/data/models/apod_model.dart';

abstract class SearchLocalDataSource {
  Future<List<ApodModel>> fetchApodByDateRange(
    String startDate,
    String endDate,
  );
}
