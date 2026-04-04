// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Astronomy Picture';

  @override
  String get loadingData => 'Loading data...';

  @override
  String get showMedia => 'Show Media';

  @override
  String get showMediaDescription =>
      'If media are not able on app, tap here to see on browser.';

  @override
  String get save => 'Save';

  @override
  String get saveDescription => 'Save this content for quick access in future.';

  @override
  String get saveonGallery => 'Save Image on Gallery';

  @override
  String get saveonGallerySaved => 'Image save on Gallery';

  @override
  String get shareMediaLink => 'Share media link';

  @override
  String get shareAllContent => 'Share All Content';

  @override
  String get searchTextExemple =>
      'Single day: YYYY-MM-DD\nRange of days: YYYY-MM-DD/YYYY-MM-DD\nOr tap the calendar icon! Is much better';

  @override
  String get bookmark => 'Bookmark';

  @override
  String get pictureDay => 'Image of the day';

  @override
  String get alertSave => 'You not save any content yet';

  @override
  String get contentRemoved => 'Content removed';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get undo => 'Undo';

  @override
  String get by => 'by';

  @override
  String get date => 'Date';

  @override
  String get setWallpaper => 'Set as Wallpaper';

  @override
  String get wallpaperUpdated => 'Wallpaper updated successfully!';

  @override
  String get wallpaperError => 'Failed to set wallpaper. Please try again.';

  @override
  String get settingWallpaper => 'Setting wallpaper...';

  @override
  String get settingWallpaperAlert =>
      'Setting wallpaper may take a few seconds...';

  @override
  String get wallpaperSuccess => 'Wallpaper applied!';

  @override
  String get setBackground => 'Set background';
}
