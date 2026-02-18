import 'package:flutter/material.dart';

void main() {
  runApp(const astronomyPicture());
}

class astronomyPicture extends StatelessWidget {
  const astronomyPicture({super.key});
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
