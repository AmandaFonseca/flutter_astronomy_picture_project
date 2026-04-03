import 'package:dartz/dartz.dart';

abstract class SetWallpaperDataSource {
  Future<Unit> setWallpaper(String url);
}
