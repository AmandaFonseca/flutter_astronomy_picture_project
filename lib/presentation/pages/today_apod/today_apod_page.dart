import 'package:astronomy_picture/container_injection.dart';
import 'package:astronomy_picture/presentation/bloc/today_apod/today_apod_bloc.dart';
import 'package:astronomy_picture/presentation/pages/today_apod/apod_view_page.dart';
import 'package:flutter/material.dart';

class TodayApodPage extends StatefulWidget {
  const TodayApodPage({super.key});

  @override
  State<TodayApodPage> createState() => _TodayApodPageState();
}

class _TodayApodPageState extends State<TodayApodPage> {
  late TodayApodBloc _bloc;

  @override
  void initState() {
    _bloc = getIt<TodayApodBloc>();
    _bloc.input.add(FecthTodayApodEvent());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TodayApodState>(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        TodayApodState? state = snapshot.data;

        Widget body = const Center(child: Text("Carregando dados..."));

        if (state is LoadingTodayApodState) {
          body = Center(child: CircularProgressIndicator());
        }

        if (state is ErrorTodayApodState) {
          body = Center(child: Text(state.msg));
        }

        if (state is SucessTodayApodState) {
          return ApodViewPage(apod: state.apod);
        }
        return Scaffold(body: body);
      },
    );
  }
}
