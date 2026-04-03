// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Astronomy Picture PT';

  @override
  String get loadingData => 'Carregando dados...';

  @override
  String get showMedia => 'Mostrar mídia';

  @override
  String get showMediaDescription =>
      'Se a mídia não estiver disponível no aplicativo, toque aqui para visualizá-la no navegador.';

  @override
  String get save => 'Salvar';

  @override
  String get saveDescription =>
      'Salve este conteúdo para acesso rápido no futuro.';

  @override
  String get saveonGallery => 'Salvar imagem na galeria';

  @override
  String get saveonGallerySaved => 'Image salva na galeria';

  @override
  String get shareMediaLink => 'Compartilhar link de mídia';

  @override
  String get shareAllContent => 'Compartilhar todo o conteúdo';

  @override
  String get searchTextExemple =>
      'Dia único: AAAA-MM-DD\nIntervalo de dias: AAAA-MM-DD/AAAA-MM-DD\nOu toque no ícone do calendário! É muito melhor.';

  @override
  String get bookmark => 'Favoritos';

  @override
  String get pictureDay => 'Foto do dia';

  @override
  String get alertSave => 'Você ainda não salvou nenhum conteúdo.';

  @override
  String get contentRemoved => 'Conteúdo removido';

  @override
  String get tryAgain => 'Tentar novamente';

  @override
  String get undo => 'Desfazer';
}
