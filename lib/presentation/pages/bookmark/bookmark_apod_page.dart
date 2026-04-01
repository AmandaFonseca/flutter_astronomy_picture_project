import 'package:astronomy_picture/container_injection.dart';
import 'package:astronomy_picture/custom_colors.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/presentation/bloc/bookmark/bookmark_apod_bloc.dart';
import 'package:astronomy_picture/presentation/core/date_convert.dart';
import 'package:astronomy_picture/presentation/pages/search/search_apod_page.dart';
import 'package:astronomy_picture/presentation/widgets/core/apod_tile.dart';
import 'package:astronomy_picture/presentation/widgets/today_apod/error_apod_widget.dart';
import 'package:flutter/material.dart';
import 'package:astronomy_picture/l10n/app_localizations.dart';

class BookmarkApodPage extends StatefulWidget {
  const BookmarkApodPage({super.key});

  @override
  State<BookmarkApodPage> createState() => _BookmarkApodPageState();
}

class _BookmarkApodPageState extends State<BookmarkApodPage> {
  late BookmarkApodBloc _bloc;
  List<Apod> _list = [];
  Apod? _cacheApod;

  @override
  void initState() {
    _bloc = getIt<BookmarkApodBloc>();
    _bloc.input.add(FetchAllSaveBookmarkApodEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchApodPage());
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          final state = snapshot.data;

          if (state is LoadingBookmarkApodState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ErrorBookmarkApodState) {
            return Center(
              child: ErrorApodWidget(
                msg: state.msg,
                color: CustomColors.vermilion,
              ),
            );
          }

          if (state is SuccessListBookmarkApodState) {
            _list = state.list;
          }

          if (_list.isEmpty) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info, color: CustomColors.white, size: 100),
                    Text(
                      AppLocalizations.of(context)!.alertSave,
                      style: TextStyle(color: CustomColors.white),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Dismissible(
                    key: Key(_list[index].date.toString()),
                    onDismissed: (direction) {
                      _cacheApod = _list.removeAt(index);
                      setState(() {
                        showSnackBar(
                          AppLocalizations.of(context)!.contentRemoved,
                          index,
                        );
                      });
                    },
                    child: ApodTile(
                      apod: _list[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/apodView',
                          arguments: _list[index],
                        ).then((_) {
                          _bloc.input.add(FetchAllSaveBookmarkApodEvent());
                        });
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void showSnackBar(String msg, int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: CustomColors.black,
          content: Text(msg),
          duration: const Duration(seconds: 6),
          onVisible: () {
            Future.delayed(const Duration(seconds: 7), () {
              if (!_list.contains(_cacheApod)) {
                _bloc.input.add(
                  RemoveSaveBookmarkApodEvent(
                    date: DateConvert.dateToString(_cacheApod!.date),
                  ),
                );
              }
            });
          },
          action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _list.insert(index, _cacheApod!);
              });
            },
          ),
        ),
      );
    });
  }
}
