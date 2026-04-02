import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class TranslationService {
  late OnDeviceTranslator translator;
  final modelManager = OnDeviceTranslatorModelManager();

  Future<void> init() async {
    final isDownloaded = await modelManager.isModelDownloaded(
      TranslateLanguage.english.bcpCode,
    );

    if (!isDownloaded) {
      await modelManager.downloadModel(TranslateLanguage.english.bcpCode);
    }

    translator = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.english,
      targetLanguage: TranslateLanguage.portuguese,
    );
  }

  Future<String> translate(String text) async {
    return await translator.translateText(text);
  }

  void close() {
    translator.close();
  }
}
