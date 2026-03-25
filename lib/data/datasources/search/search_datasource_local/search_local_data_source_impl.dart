import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/core/shared_keys.dart';
import 'package:astronomy_picture/data/datasources/search/search_datasource_local/search_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  final SharedPreferences sharedPreferences;

  SearchLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<String>> fetchSearchHistory() async {
    try {
      return sharedPreferences.getStringList(SharedKeys.historyKey) ?? [];
    } catch (e) {
      throw AccessLocalDataFailure();
    }
  }

  @override
  Future<List<String>> updateSearchHistory(List<String> history) async {
    try {
      await sharedPreferences.setStringList(SharedKeys.historyKey, history);
      return fetchSearchHistory();
    } catch (e) {
      throw AccessLocalDataFailure();
    }
  }
}
