// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movieapp/src/features/movies/presentation/cubit/movie_details/movie_details_cubit.dart';
import 'package:movieapp/src/features/movies/presentation/screens/details_description.dart';

import 'package:share_plus/share_plus.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../constants/constants.dart';

class DetailsScreen extends StatefulWidget {
  int movieId;
  String ytLink;
  DetailsScreen({
    Key? key,
    required this.movieId,
    required this.ytLink,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<MovieDetailsCubit>()
        .getMovieDetail(widget.movieId, widget.ytLink);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          if (state is LoadingDetailsState) {
            return Center(
              child: SpinKitDoubleBounce(color: mainColor),
            );
          } else if (state is LoadedDetailsState) {
            final movie = state.movie;
            return DescriptionBody(
              description: movie.description,
              link: movie.sharelink ?? 'sorry link couldn not be provided',
              cast: movie.cast ?? [],
              genre: movie.genres ?? [],
              image: movie.image,
              rating: movie.rating ?? 'E',
              releasedYear: movie.releaseYear ?? 0000,
              title: movie.title,
              youtubeTrailerLink: widget.ytLink,
              torrentLink: movie.torrentLink ??
                  'https://yts.mx/torrent/download/94A0965EA141140B007B96892778F1642CF86BE8',
            );
          } else {
            return Center(
              child: Text(
                'Opps! Could not fetch movie details',
                style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            );
          }
        },
      ),
    );
  }
}



// class CheckPermission {
//   Future<bool> isStoragePermission() async {
//     var isStorage = await Permission.storage.status;
//     var isAccessLc = await Permission.accessMediaLocation.status;
//     var isMnagExt = await Permission.manageExternalStorage.status;

//     if (!isStorage.isGranted || !isAccessLc.isGranted || !isMnagExt.isGranted) {
//       await Permission.storage.request();
//       await Permission.accessMediaLocation.request();
//       await Permission.manageExternalStorage.request();
//       if (!isStorage.isGranted ||
//           !isAccessLc.isGranted ||
//           !isMnagExt.isGranted) {
//         return false;
//       } else {
//         return true;
//       }
//     } else {
//       return true;
//     }
//   }
// }

// class DirectoryPath {
//   getPath() async {
//     final path = Directory(
//         "/storage/emulated/0/Android/media/com.example.movieapp/files");
//     if (await path.exists()) {
//       return path.path;
//     } else {
//       path.create();
//       return path.path;
//     }
//   }
// }
