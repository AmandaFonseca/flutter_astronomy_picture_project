import 'package:astronomy_picture/data/models/apod_model.dart';

abstract class FetchApodsDataSource {
  Future<List<ApodModel>> fetchApods();
}
