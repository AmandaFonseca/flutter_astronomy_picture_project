import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/presentation/pages/bookmark/bookmark_apod_page.dart';
import 'package:astronomy_picture/presentation/pages/featch_apods/featch_apods_page.dart';
import 'package:astronomy_picture/presentation/pages/today_apod/apod_view_page.dart';
import 'package:astronomy_picture/presentation/pages/today_apod/today_apod_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: _mapRaouteName(settings.name, settings.arguments),
    );
  }

  Widget Function(BuildContext) _mapRaouteName(
    String? name,
    Object? arguments,
  ) {
    switch (name) {
      case '/':
        return (_) => const FetchApodsPage();
      case '/apodView':
        if (arguments is Apod) {
          return (_) => ApodViewPage(apod: arguments);
        } else {
          return (_) => _errorPage();
        }
      case '/apodToday':
        return (_) => const TodayApodPage();
      case '/bookmark':
        return (_) => const BookmarkApodPage();
      default:
        return (_) => _errorPage();
    }
  }

  Widget _errorPage() {
    return Scaffold(
      appBar: AppBar(title: const Text("Error")),
      body: const Center(child: Text("Navigator Error")),
    );
  }
}
