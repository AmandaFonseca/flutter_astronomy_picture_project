import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/set_wallpaper/set_wallpaper_data_remote/set_wallpaper_data_source.dart';
import 'package:astronomy_picture/domain/repositores/set_wallpaper/set_wallpaper_repository.dart';
import 'package:dartz/dartz.dart';

class SetWallpaperRepositoryImpl implements SetWallpaperRepository {
  final SetWallpaperDataSource dataSource;

  SetWallpaperRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Unit>> setWallpaper(String url) async {
    try {
      await dataSource.setWallpaper(url);

      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
