import 'package:bloc_test/bloc/api_bloc.dart';
import 'package:bloc_test/ui/get_users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /**
          --------------- Focus Here   -----------------------
       **/
      home: BlocProvider(
        create: (_) => ApiBloc(),
        child: const MyBlocPage(),
      ),
    );
    /**
        --------------- Focus Here  -----------------------
     **/
  }
}
