import 'dart:ui';
import 'package:astronomy_picture/data/repositories/core/translator_service.dart';

class DeviceInfo {
  final TranslationService translator;

  DeviceInfo({required this.translator});

  bool get deviceIsEnglish {
    final locale = PlatformDispatcher.instance.locale;
    return locale.languageCode.toLowerCase().startsWith('en');
  }

  Future<String> translateIfNeeded(String text) async {
    if (deviceIsEnglish) return text;
    return await translator.translate(text);
  }
}
