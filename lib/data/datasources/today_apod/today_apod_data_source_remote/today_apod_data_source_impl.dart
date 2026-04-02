import 'dart:convert';

import 'package:astronomy_picture/core/constants/urls_constants.dart';
import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_data_source_remote/today_apod_data_source.dart';
import 'package:astronomy_picture/data/repositories/core/translator_service.dart';
import 'package:astronomy_picture/data/models/apod_model.dart';
import 'package:http/http.dart' as http;

class TodayApodDataSourceImpl implements TodayApodDataSource {
  final http.Client client;
  final TranslationService translator;
  TodayApodDataSourceImpl({required this.client, required this.translator});

  @override
  Future<ApodModel> fecthTodayApod() async {
    http.Response response;
    try {
      response = await client.get(Uri.parse(UrlsConstantes.apodUrl));
    } catch (e) {
      throw ApiFailure();
    }
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(
        utf8.decode(response.bodyBytes),
      );

      if (json['title'] != null) {
        json['title'] = await translator.translate(json['title']);
      }

      if (json['explanation'] != null) {
        json['explanation'] = await translator.translate(json['explanation']);
      }

      return ApodModel.fromJson(json);
    } else {
      throw ApiFailure();
    }
  }
}
