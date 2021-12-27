import 'package:majootestcase/ui/home_bloc/home_bloc_screen.dart';
import 'package:majootestcase/ui/login/login_page.dart';
import 'package:flutter/foundation.dart';
import 'bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc/home_bloc_cubit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) =>
        AuthBlocCubit(
        )
          ..fetch_history_login(),
        child: MyHomePageScreen(),
      ),
    );
  }
}

class MyHomePageScreen extends StatelessWidget {
  const MyHomePageScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBlocCubit, AuthBlocState>(
        builder: (context, state)
        {
          if(state is AuthBlocLoginState)
          {
            return LoginPage();
          }
          else if(state is AuthBlocLoggedInState)
          {
            return BlocProvider(
              create: (context) =>
              HomeBlocCubit(
              )
                ..fetching_data(),
              child: HomeBlocScreen(),
            );
          }

          return Center(child: Text(
              kDebugMode?"state not implemented $state": ""
          ));
        });
  }
}

