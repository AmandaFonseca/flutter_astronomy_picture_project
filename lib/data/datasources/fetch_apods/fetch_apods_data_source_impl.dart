import 'dart:convert';

import 'package:astronomy_picture/core/constants/urls_constants.dart';
import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/fetch_apods/fetch_apods_data_source.dart';
import 'package:astronomy_picture/data/models/apod_model.dart';
import 'package:astronomy_picture/data/repositories/core/translator_service.dart';
import 'package:http/http.dart' as http;

class FetchApodsDataSourceImpl implements FetchApodsDataSource {
  final http.Client client;
  final TranslationService translator;
  FetchApodsDataSourceImpl({required this.client, required this.translator});

  @override
  Future<List<ApodModel>> fetchApods() async {
    http.Response response;
    try {
      response = await client.get(
        Uri.parse("${UrlsConstantes.apodUrl}&count=20"),
      );
    } catch (e) {
      throw ApiFailure();
    }
    if (response.statusCode == 200) {
      final List<ApodModel> apods = [];

      var json = jsonDecode(utf8.decode(response.bodyBytes));

      for (final item in json) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(item);

        if (json['title'] != null) {
          json['title'] = await translator.translate(json['title']);
        }

        if (json['explanation'] != null) {
          json['explanation'] = await translator.translate(json['explanation']);
        }

        apods.add(ApodModel.fromJson(json));
      }

      return apods;

      //return List.from(json.map((e) => ApodModel.fromJson(e)));
    } else {
      throw ApiFailure();
    }
  }
}
