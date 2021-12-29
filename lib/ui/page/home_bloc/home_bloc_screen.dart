import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_cubit.dart';
import 'package:majootestcase/bloc/home_bloc/home_bloc_state.dart';
import 'package:majootestcase/data/controller/api_service.dart';
import 'package:majootestcase/ui/extra/error_screen.dart';
import 'package:majootestcase/ui/extra/loading.dart';

import 'home_bloc_loaded_screen.dart';

class HomeBlocScreen extends StatelessWidget {
  HomeBlocScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBlocCubit, HomeBlocState>(
      bloc: BlocProvider.of<HomeBlocCubit>(context),
      builder: (context, state) {
        log("APA NIH >>$state");
        if (state is HomeBlocLoadedState) {
          if (state.data != null) {
            return HomeBlocLoadedScreen(data: [state.data]);
          } else {
            return ErrorScreen(
              iconNetwork: Icons.wifi_off,
              retry: () {},
              retryButton: ElevatedButton(
                  onPressed: () async {
                    HomeBlocCubit(apiServices)..apiServices.getMovieList();
                    var data = await apiServices.getMovieList();
                    return HomeBlocLoadedState(data);
                  },
                  child: Text("Refresh ")),
            );
          }
        } else if (state is HomeBlocLoadingState) {
          return LoadingIndicator();
        } else if (state is HomeBlocInitialState) {
          return Scaffold();
        } else if (state is HomeBlocErrorState) {
          return ErrorScreen(message: state.message);
        }
        return Center(
            child: Text(kDebugMode ? "state not implemented $state" : ""));
      },
    );
  }
}
