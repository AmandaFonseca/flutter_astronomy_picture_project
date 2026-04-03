import 'dart:io';
import 'package:astronomy_picture/data/datasources/set_wallpaper/set_wallpaper_data_remote/set_wallpaper_data_source.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class SetWallpaperDataSourceImpl implements SetWallpaperDataSource {
  final http.Client _client;

  SetWallpaperDataSourceImpl(this._client);

  @override
  Future<Unit> setWallpaper(String url) async {
    try {
      final response = await _client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/temp_apod_wallpaper.jpg');
        await file.writeAsBytes(response.bodyBytes);

        await AsyncWallpaper.setWallpaperFromFile(
          filePath: file.path,
          wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
          goToHome: true,
        );

        return unit;
      } else {
        throw Exception(
          "Error downloading image: Status ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Technical failure in the DataSource: $e");
    }
  }
}
