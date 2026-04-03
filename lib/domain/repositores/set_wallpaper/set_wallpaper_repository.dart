import 'package:astronomy_picture/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class SetWallpaperRepository {
  Future<Either<Failure, Unit>> setWallpaper(String url);
}
