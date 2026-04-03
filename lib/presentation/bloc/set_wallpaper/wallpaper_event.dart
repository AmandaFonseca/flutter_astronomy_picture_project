part of 'wallpaper_bloc.dart';

abstract class WallpaperEvent extends Equatable {
  const WallpaperEvent();

  @override
  List<Object?> get props => [];
}

class SetWallpaperStarted extends WallpaperEvent {
  final String url;

  const SetWallpaperStarted(this.url);

  @override
  List<Object?> get props => [url];
}
