import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movieapp/src/features/account/data/models/user_model.dart';
import 'package:movieapp/src/features/account/data/repository/account_repository.dart';
import 'package:movieapp/src/features/account/presentation/cubit/account/account_cubit.dart';

import 'package:movieapp/src/features/movies/data/Repository/movie_repository.dart';
import 'package:movieapp/src/features/movies/presentation/cubit/movie_details/movie_details_cubit.dart';
import 'package:movieapp/src/features/movies/presentation/cubit/movie_search/movie_search_cubit.dart';
import 'package:movieapp/src/features/movies/presentation/cubit/movies_list/movies_cubit.dart';
import 'package:movieapp/src/features/movies/presentation/screens/bottomNavBar.dart';
import 'package:movieapp/torrent_test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<List>('downloads');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool checker = false;

  MyApp({super.key});

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
        BlocProvider<MovieSearchCubit>(
          create: (context) =>
              MovieSearchCubit(repository: MovieRepository(Dio())),
        ),
        BlocProvider<AccountCubit>(
          create: (context) =>
              AccountCubit(repository: AccountRepository(Dio())),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: TorrentTest(),
        home: BottomBar(),
      ),
    );
  }
}


//magnet:?xt=urn:btih:TORRENT_HASH&dn=Url+Encoded+Movie+Name&tr=http://track.one:1234/announce&tr=udp://track.two:80

//https://yts.mx/movies/craftivism-making-a-difference-2021
//35FFF2F496645EE3CBDA8567DF95431C25023458



//magnet:?xt=urn:btih:35FFF2F496645EE3CBDA8567DF95431C25023458&dn=https://yts.mx/movies/craftivism-making-a-difference-2021&tr=http://track.one:1234/announce&tr=udp://track.two:80

