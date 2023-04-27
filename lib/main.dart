import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/cubit/movies_list/movies_cubit.dart';
import 'package:movieapp/data/Repository/movie_repository.dart';
import 'package:movieapp/presentation/screens/bottomNavBar.dart';

import 'package:movieapp/presentation/screens/home_screen.dart';

import 'cubit/movie_details/movie_details_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesCubit>(
          create: (context) => MoviesCubit(repository: MovieRepository(Dio())),
        ),
        BlocProvider<MovieDetailsCubit>(
          create: (context) =>
              MovieDetailsCubit(repository: MovieRepository(Dio())),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BottomBar(),
      ),
    );
  }
}


//learn about blclistener, blocconsumer, blocbuilder