import 'package:astronomy_picture/container_injection.dart';
import 'package:astronomy_picture/presentation/pages/today_apod/today_apod_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpContainer();
  runApp(const AstronomyPicture());
}

class AstronomyPicture extends StatelessWidget {
  const AstronomyPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Astronomy Picture', home: TodayApodPage());
  }
}
