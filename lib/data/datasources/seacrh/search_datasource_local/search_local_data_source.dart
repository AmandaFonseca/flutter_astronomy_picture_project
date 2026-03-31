abstract class SearchLocalDataSource {
  Future<List<String>> fetchSearchHistory();
  Future<List<String>> updateSearchHistory(List<String> historyList);
}
