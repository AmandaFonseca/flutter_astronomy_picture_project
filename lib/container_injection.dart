import 'package:astronomy_picture/data/datasources/network/network_info.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_data_source.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_data_source_impl.dart';
import 'package:astronomy_picture/data/repositories/today_apod/today_apod_repository_impl.dart';
import 'package:astronomy_picture/domain/repositores/today_apod/today_apod_repository.dart';
import 'package:astronomy_picture/domain/usecases/today_apod/fetch_apod_today.dart';
import 'package:astronomy_picture/presentation/bloc/today_apod/today_apod_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

GetIt getIt = GetIt.instance;

Future<void> setUpContainer() async {
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(internetConnection: getIt()),
  );

  apodToday();
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
