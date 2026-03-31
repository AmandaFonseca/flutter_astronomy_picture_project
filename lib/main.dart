import 'package:astronomy_picture/container_injection.dart';
import 'package:astronomy_picture/route_generator.dart';
import 'package:astronomy_picture/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await setUpContainer();
  runApp(const AstronomyPicture());
}

class AstronomyPicture extends StatelessWidget {
  const AstronomyPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Astronomy Picture',
      onGenerateRoute: getIt<RouteGenerator>().generateRoute,
      theme: CustomTheme.getTheme(),
      initialRoute: '/',
    );
  }
}
