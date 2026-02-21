import 'package:flutter/material.dart';

void main() {
  runApp(const AstronomyPicture());
}

class AstronomyPicture extends StatelessWidget {
  const AstronomyPicture({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Astronomy Picture',
      home: Scaffold(
        appBar: AppBar(title: const Text('Astronomy Picture')),
        body: const Center(
          child: Text('Welcome to the Astronomy Picture App!'),
        ),
      ),
    );
  }
}
