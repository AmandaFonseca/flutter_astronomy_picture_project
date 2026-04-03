import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/repositores/set_wallpaper/set_wallpaper_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SetWallpaperUseCase {
  final SetWallpaperRepository repository;

  SetWallpaperUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(WallpaperParams params) async {
    return await repository.setWallpaper(params.url);
  }
}

class WallpaperParams extends Equatable {
  final String url;

  const WallpaperParams({required this.url});

  @override
  List<Object?> get props => [url];
}
