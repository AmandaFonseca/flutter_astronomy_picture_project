import 'dart:convert';

import 'package:flutter_astronomy_picture_project/core/failure.dart';
import 'package:flutter_astronomy_picture_project/data/datasources/today_apod/today_apod_data_source.dart';
import 'package:flutter_astronomy_picture_project/data/models/apod_model.dart';
import 'package:flutter_astronomy_picture_project/environment.dart';
import 'package:http/http.dart' as http;

class TodayApodDataSourceImpl extends TodayApodDataSource {
  final http.Client client;
  TodayApodDataSourceImpl({required this.client});

  @override
  Future<ApodModel> fecthTodayApod() async {
    http.Response response;
    try {
      response = await client.get(Uri.parse(Environment.urlBase));
    } catch (e) {
      throw ApiFailure();
    }

    if (response.statusCode == 200) {
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      return ApodModel.fromJson(json);
    } else {
      throw ApiFailure();
    }
  }
}
