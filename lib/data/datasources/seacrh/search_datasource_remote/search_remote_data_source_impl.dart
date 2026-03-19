import 'dart:convert';

import 'package:astronomy_picture/core/constants/urls_constants.dart';
import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/seacrh/search_datasource_remote/search_remote_data_source_.dart';
import 'package:astronomy_picture/data/models/apod_model.dart';
import 'package:http/http.dart' as http;

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final http.Client client;
  SearchRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ApodModel>> fetchApodByDateRange(
    String startDate,
    String endDate,
  ) async {
    http.Response response;

    final url =
        '${UrlsConstantes.apodUrl}&start_date=$startDate&end_date=$endDate';

    try {
      response = await client.get(Uri.parse(url));
    } catch (e) {
      throw ApiFailure();
    }

    if (response.statusCode == 200) {
      final List jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      return jsonList
          .map((item) => ApodModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw ApiFailure();
    }
  }
}
