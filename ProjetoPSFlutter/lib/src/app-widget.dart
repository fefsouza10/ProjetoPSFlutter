import 'package:ProjetoPSFlutter/src/app-bloc.dart';
import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ProjetoPSFlutter/src/login/login-widget.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      bloc: AppBloc(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purpleAccent[500],
        ),
        home: LoginWidget(),
      ),
    );
  }
}