import 'dart:convert';

import 'package:astronomy_picture/core/constants/urls_constants.dart';
import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/seacrh/search_datasource_remote/search_remote_data_source_.dart';
import 'package:astronomy_picture/data/models/apod_model.dart';
import 'package:astronomy_picture/data/repositories/core/translator_service.dart';
import 'package:astronomy_picture/core/device_info.dart';

import 'package:http/http.dart' as http;

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final http.Client client;
  final TranslationService translator;
  final DeviceInfo deviceInfo;

  SearchRemoteDataSourceImpl({
    required this.client,
    required this.translator,
    required this.deviceInfo,
  });

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
      final List<Future<ApodModel>> translationTasks = jsonList.map((
        item,
      ) async {
        final Map<String, dynamic> json = Map<String, dynamic>.from(item);
        if (json['title'] != null) {
          json['title'] = await deviceInfo.translateIfNeeded(json['title']);
        }
        return ApodModel.fromJson(json);
      }).toList();
      return await Future.wait(translationTasks);
    } else {
      throw ApiFailure();
    }
  }
}
