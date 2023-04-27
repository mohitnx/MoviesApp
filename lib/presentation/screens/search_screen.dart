import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/constants.dart';
import 'package:movieapp/cubit/movies_list/movies_cubit.dart';

import '../widgets/popular_movies_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(
          right: 20.0,
          left: 20.0,
          bottom: 10.0,
          top: 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 32),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(212, 12, 10, 20),
                  spreadRadius: 4,
                  blurRadius: 30,
                ),
              ]),
              child: TextFormField(
                style: TextStyle(color: secondaryTextColor),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 15),
                  focusedBorder: InputBorder.none,
                  hintText: 'Search title, categories, etc...',
                  hintStyle: TextStyle(color: secondaryTextColor),
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: mainColor,
                  ),
                  filled: true,
                  fillColor: backgroundColor,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0, color: backgroundColor),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Popular Search',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 18),
            ),
            const SizedBox(
              height: 24,
            ),
            BlocBuilder<MoviesCubit, MoviesState>(
              builder: (context, state) {
                //implement loading properly later
                if (state is LoadingState) {
                  return Center(
                    child: SizedBox(
                        height: 40,
                        child: CircularProgressIndicator(color: mainColor)),
                  );
                } else if (state is LoadedState) {
                  //we have a list of 40 moveis..we shuffle evertime and show only 5 movies
                  //if the user clicks see all then only we show the list of all the moves
                  //done this because the api to get popular moveis needs login and most other movie apis are blocked
                  final temp = state.movies;
                  final movies = temp.sublist(0, 19);
                  movies.shuffle();
                  return Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return popularMoviesVertical(
                          context,
                          movies[index].title,
                          movies[index].description,
                          movies[index].image,
                          movies[index].genres,
                          movies[index].id,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 22,
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      'Opps! Could not fetch popular searched movies',
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
