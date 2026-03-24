import 'package:astronomy_picture/presentation/pages/search/search_apod_page.dart';
import 'package:flutter/material.dart';

class FetchApodsPage extends StatefulWidget {
  const FetchApodsPage({super.key});

  @override
  State<FetchApodsPage> createState() => _FetchApodsPageState();
}

class _FetchApodsPageState extends State<FetchApodsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchApodPage());
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
