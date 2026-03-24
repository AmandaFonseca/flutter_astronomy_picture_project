import 'dart:convert';

import 'package:astronomy_picture/core/constants/urls_constants.dart';
import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/fetch_apods/fetch_apods_data_source.dart';
import 'package:astronomy_picture/data/models/apod_model.dart';
import 'package:http/http.dart' as http;

class FetchApodsDataSourceImpl implements FetchApodsDataSource {
  final http.Client client;
  FetchApodsDataSourceImpl({required this.client});

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
      var json = jsonDecode(utf8.decode(response.bodyBytes));
      return List.from(json.map((e) => ApodModel.fromJson(e)));
    } else {
      throw ApiFailure();
    }
  }
}
