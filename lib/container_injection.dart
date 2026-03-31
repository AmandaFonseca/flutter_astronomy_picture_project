import 'package:astronomy_picture/data/datasources/bookmark/bookmark_datasource_local/bookmark_apod_data_source.dart';
import 'package:astronomy_picture/data/datasources/bookmark/bookmark_datasource_local/bookmark_apod_data_source_impl.dart';
import 'package:astronomy_picture/data/datasources/fetch_apods/fetch_apods_data_source.dart';
import 'package:astronomy_picture/data/datasources/fetch_apods/fetch_apods_data_source_impl.dart';
import 'package:astronomy_picture/data/datasources/network/network_info.dart';
import 'package:astronomy_picture/data/datasources/seacrh/search_datasource_local/search_local_data_source.dart';
import 'package:astronomy_picture/data/datasources/seacrh/search_datasource_local/search_local_data_source_impl.dart';
import 'package:astronomy_picture/data/datasources/seacrh/search_datasource_remote/search_remote_data_source_.dart';
import 'package:astronomy_picture/data/datasources/seacrh/search_datasource_remote/search_remote_data_source_impl.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_data_source_remote/today_apod_data_source.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_data_source_remote/today_apod_data_source_impl.dart';
import 'package:astronomy_picture/data/repositories/bookmark/bookmark_repository_impl.dart';
import 'package:astronomy_picture/data/repositories/fetch_apods/fetch_apods_repository_impl.dart';
import 'package:astronomy_picture/data/repositories/search/search_repository_impl.dart';

import 'package:astronomy_picture/data/repositories/today_apod/today_apod_repository_impl.dart';
import 'package:astronomy_picture/domain/repositores/bookmark/bookmark_repository.dart';
import 'package:astronomy_picture/domain/repositores/fetch_apods/fetch_apods_repository.dart';
import 'package:astronomy_picture/domain/repositores/search/search_repository.dart';
import 'package:astronomy_picture/domain/repositores/today_apod/today_apod_repository.dart';
import 'package:astronomy_picture/domain/usecases/bookmark/apod_is_save.dart';
import 'package:astronomy_picture/domain/usecases/bookmark/fetch_all_apods_saved.dart';
import 'package:astronomy_picture/domain/usecases/bookmark/remove_save_apod.dart';
import 'package:astronomy_picture/domain/usecases/bookmark/save_apod.dart';
import 'package:astronomy_picture/domain/usecases/fetch_apods/fetch_apods.dart';
import 'package:astronomy_picture/domain/usecases/search/fecth_apod_by_range.dart';
import 'package:astronomy_picture/domain/usecases/search/fetch_search_history.dart';
import 'package:astronomy_picture/domain/usecases/search/update_search_history.dart';
import 'package:astronomy_picture/domain/usecases/today_apod/fetch_apod_today.dart';
import 'package:astronomy_picture/presentation/bloc/bookmark/bookmark_apod_bloc.dart';
import 'package:astronomy_picture/presentation/bloc/fetch_apods/fetch_apods_bloc.dart';
import 'package:astronomy_picture/presentation/bloc/search/search_bloc.dart';
import 'package:astronomy_picture/presentation/bloc/today_apod/today_apod_bloc.dart';
import 'package:astronomy_picture/route_generator.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

Future<void> setUpContainer() async {
  // Externas
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Internas
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(internetConnection: getIt()),
  );

  //routes
  getIt.registerSingleton<RouteGenerator>(RouteGenerator());

  // Features
  apodToday();
  searchFeature();
  fetchApods();
  bookmarks();
}

void apodToday() {
  getIt.registerLazySingleton<TodayApodDataSource>(
    () => TodayApodDataSourceImpl(client: getIt()),
  );
  getIt.registerLazySingleton<TodayApodRepository>(
    () => TodayApodRepositoryImpl(dataSource: getIt(), networkInfo: getIt()),
  );
  getIt.registerLazySingleton<FetchApodToday>(
    () => FetchApodToday(todayApodRepository: getIt()),
  );
  getIt.registerFactory(() => TodayApodBloc(usecase: getIt()));
}

void searchFeature() {
  getIt.registerLazySingleton<SearchLocalDataSource>(
    () => SearchLocalDataSourceImpl(sharedPreferences: getIt()),
  );
  getIt.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(client: getIt()),
  );

  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      localDataSource: getIt(),
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  getIt.registerLazySingleton(() => FetchSearchHistory(repository: getIt()));
  getIt.registerLazySingleton(() => FetchApodByRange(repository: getIt()));
  getIt.registerLazySingleton(() => UpdateSearchHistory(repository: getIt()));

  getIt.registerFactory(
    () => SearchBloc(
      fetchSearchHistory: getIt(),
      updateSearchHistory: getIt(),
      fetchApodByDataRange: getIt(),
    ),
  );
}

void fetchApods() {
  getIt.registerLazySingleton<FetchApodsDataSource>(
    () => FetchApodsDataSourceImpl(client: getIt()),
  );

  getIt.registerLazySingleton<FetchApodsRepository>(
    () => FetchApodsRepositoryImpl(
      fetchApodsDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  getIt.registerLazySingleton(() => FetchApods(repository: getIt()));

  getIt.registerFactory(() => FetchApodsBloc(fetchApods: getIt()));
}

void bookmarks() {
  getIt.registerLazySingleton<BookmarkApodDataSource>(
    () => BookmarkApodDataSourceImpl(preferences: getIt()),
  );

  getIt.registerLazySingleton<BookmarkRepository>(
    () => BookmarkApodRepositoryImpl(bookmarkApodDataSource: getIt()),
  );

  getIt.registerLazySingleton(() => ApodIsSave(repository: getIt()));
  getIt.registerLazySingleton(() => FetchAllApodSave(repository: getIt()));
  getIt.registerLazySingleton(() => RemoveSaveApod(repository: getIt()));
  getIt.registerLazySingleton(() => SaveApod(repository: getIt()));

  getIt.registerFactory(
    () => BookmarkApodBloc(
      apodIsSave: getIt(),
      fetchAllApodSave: getIt(),
      removeSaveApod: getIt(),
      saveApod: getIt(),
    ),
  );
}
