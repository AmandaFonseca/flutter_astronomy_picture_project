import 'dart:convert';

import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/shared_keys.dart';
import 'package:astronomy_picture/core/success.dart';
import 'package:astronomy_picture/data/datasources/bookmark/bookmark_datasource_local/bookmark_apod_data_source.dart';
import 'package:astronomy_picture/data/models/apod_model.dart';
import 'package:astronomy_picture/presentation/core/date_convert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkApodDataSourceImpl extends BookmarkApodDataSource {
  final SharedPreferences preferences;
  BookmarkApodDataSourceImpl({required this.preferences});

  @override
  Future<bool> apodIsSave(String apodDate) async {
    try {
      return preferences.containsKey(apodDate);
    } catch (e) {
      throw AccessLocalDataFailure();
    }
  }

  @override
  Future<List<ApodModel>> getAllApodSave() async {
    try {
      final keys = preferences.getKeys();
      keys.remove(SharedKeys.historyKey);

      List<ApodModel> apods = [];
      for (var key in keys) {
        final apod = preferences.getString(key);
        if (apod != null) {
          apods.add(ApodModel.fromJson(jsonDecode(apod)));
        }
      }
      return apods;
    } catch (e) {
      throw AccessLocalDataFailure();
    }
  }

  @override
  Future<ApodRemoved> removeSaveApod(String apodDate) async {
    try {
      await preferences.remove(apodDate);
      return ApodRemoved();
    } catch (e) {
      throw AccessLocalDataFailure();
    }
  }

  @override
  Future<ApodSaved> saveApod(ApodModel apod) async {
    try {
      await preferences.setString(
        DateConvert.dateToString(apod.date),
        jsonEncode(apod.toJson()),
      );
      return ApodSaved();
    } catch (e) {
      throw AccessLocalDataFailure();
    }
  }
}
