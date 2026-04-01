import 'package:astronomy_picture/container_injection.dart';
import 'package:astronomy_picture/custom_colors.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/l10n/app_localizations.dart';
import 'package:astronomy_picture/presentation/bloc/fetch_apods/fetch_apods_bloc.dart';
import 'package:astronomy_picture/presentation/pages/search/search_apod_page.dart';
import 'package:astronomy_picture/presentation/widgets/core/apod_tile.dart';
import 'package:astronomy_picture/presentation/widgets/today_apod/error_apod_widget.dart';
import 'package:flutter/material.dart';

class FetchApodsPage extends StatefulWidget {
  const FetchApodsPage({super.key});

  @override
  State<FetchApodsPage> createState() => _FetchApodsPageState();
}

class _FetchApodsPageState extends State<FetchApodsPage> {
  final ScrollController _scrollController = ScrollController();
  late FetchApodsBloc _fetchApodsBloc;
  List<Apod> apodList = [];

  @override
  void initState() {
    _fetchApodsBloc = getIt<FetchApodsBloc>();
    _fetchApodsBloc.input.add(MakeFetchApodsEvent());

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _fetchApodsBloc.input.add(MakeFetchApodsEvent());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchApodPage());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _fetchApodsBloc.stream,
        builder: (context, snapshot) {
          FetchApodsState? state = snapshot.data;
          Widget child = const CircularProgressIndicator();

          if (state is SuccessListFetchApods) {
            apodList.addAll(state.list);
          }

          if (state is ErrorFetchApodsState) {
            child = ErrorApodWidget(
              msg: state.msg,
              onRetry: () {
                apodList.clear();
                _fetchApodsBloc.input.add(MakeFetchApodsEvent());
              },
              color: CustomColors.vermilion,
            );
          }

          return RefreshIndicator(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: apodList.length + 1,
              itemBuilder: (context, index) {
                if (index < apodList.length) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ApodTile(
                      apod: apodList[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/apodView',
                          arguments: apodList[index],
                        );
                      },
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Center(child: child),
                  );
                }
              },
            ),
            onRefresh: () async {
              apodList.clear();
              _fetchApodsBloc.input.add(MakeFetchApodsEvent());
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.bookmark),
            label: AppLocalizations.of(context)!.bookmark,
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: const Icon(Icons.today),
            label: AppLocalizations.of(context)!.pictureDay,
          ),
        ],
        onTap: (value) {
          if (value == 0) {
            Navigator.pushNamed(context, '/bookmark');
          }

          if (value == 2) {
            Navigator.pushNamed(context, '/apodToday');
          }
        },
      ),
    );
  }
}
