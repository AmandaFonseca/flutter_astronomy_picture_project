import 'package:astronomy_picture/core/success.dart';
import 'package:astronomy_picture/data/models/apod_model.dart';

abstract class BookmarkApodDataSource {
  Future<ApodSaved> saveApod(ApodModel apod);

  Future<ApodRemoved> removeSaveApod(String apodDate);

  Future<bool> apodIsSave(String apodDate);

  Future<List<ApodModel>> getAllApodSave();
}
