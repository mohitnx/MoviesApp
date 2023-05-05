// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:movieapp/src/constants/constants.dart';

import '../cubit/movies_list/movies_cubit.dart';
import '../widgets/popular_movies_list.dart';

class MoviesList extends StatefulWidget {
  bool isPopularList;
  MoviesList({
    Key? key,
    required this.isPopularList,
  }) : super(key: key);

  @override
  State<MoviesList> createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(
            left: 14.0, right: 12.0, bottom: 4.0, top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isPopularList ? 'Popular Movies' : 'New On Cinema',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<MoviesCubit, MoviesState>(
              builder: (context, state) {
                //implement loading properly later
                if (state is LoadingState) {
                  return Center(
                    child: SizedBox(
                      height: 40,
                      child: SpinKitDoubleBounce(color: mainColor),
                    ),
                  );
                } else if (state is LoadedState) {
                  //if the list is popular list use first 19 searchs to make the list
                  //if the lsit is new cinema use all the movies
                  final temp = state.movies;
                  final movies =
                      widget.isPopularList ? temp.sublist(0, 19) : temp;
                  movies.shuffle();
                  return Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return popularMoviesVertical(
                          context,
                          movies[index].title,
                          movies[index].description,
                          movies[index].image,
                          movies[index].genres,
                          movies[index].id,
                          movies[index].youtubelink!,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: 15,
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      'Opps! Could not fetch popular movies',
                      style: TextStyle(
                          color: mainColor, fontWeight: FontWeight.bold),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
