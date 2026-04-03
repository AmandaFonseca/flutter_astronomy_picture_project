import 'dart:async';
import 'package:astronomy_picture/domain/usecases/set_wallpaper/set_wallpaper.dart';
import 'package:equatable/equatable.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc {
  final SetWallpaperUseCase setWallpaperUseCase;

  final StreamController<WallpaperEvent> _inputController =
      StreamController<WallpaperEvent>();
  final StreamController<WallpaperState> _outputController =
      StreamController<WallpaperState>.broadcast();

  Sink<WallpaperEvent> get input => _inputController.sink;
  Stream<WallpaperState> get output => _outputController.stream;

  WallpaperBloc({required this.setWallpaperUseCase}) {
    _inputController.stream.listen(_blocEventController);
  }

  void _blocEventController(WallpaperEvent event) async {
    if (event is SetWallpaperStarted) {
      _outputController.add(WallpaperLoading());

      final result = await setWallpaperUseCase(WallpaperParams(url: event.url));

      result.fold(
        (failure) {
          _outputController.add(
            const WallpaperError("Error setting wallpaper"),
          );
        },
        (_) {
          _outputController.add(WallpaperSuccess());
        },
      );
    }
  }

  void dispose() {
    _inputController.close();
    _outputController.close();
  }
}
