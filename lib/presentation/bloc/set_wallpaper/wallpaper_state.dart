part of 'wallpaper_bloc.dart';

abstract class WallpaperState extends Equatable {
  const WallpaperState();

  @override
  List<Object?> get props => [];
}

class WallpaperInitial extends WallpaperState {}

class WallpaperLoading extends WallpaperState {}

class WallpaperSuccess extends WallpaperState {}

class WallpaperError extends WallpaperState {
  final String message;
  const WallpaperError(this.message);

  @override
  List<Object?> get props => [message];
}
