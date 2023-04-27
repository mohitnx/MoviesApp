import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/constants.dart';
import 'package:movieapp/cubit/movies_list/movies_cubit.dart';
import 'package:movieapp/data/Repository/movie_repository.dart';
import 'package:movieapp/presentation/widgets/custom_button.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:movieapp/presentation/widgets/new_movies_list.dart';
import 'package:movieapp/presentation/widgets/popular_movies_list.dart';

import '../widgets/custom_carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.52,
                  child: BlocBuilder<MoviesCubit, MoviesState>(
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return Center(
                          child: CircularProgressIndicator(color: mainColor),
                        );
                      } else if (state is LoadedState) {
                        final movie = state.movies;
                        final random_index = Random().nextInt(19);
                        return Image.network(
                          movie[random_index].image,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.52,
                          fit: BoxFit.fill,
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('this gesture detecotr worksss');
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 158, 158, 158).withOpacity(0.0),
                          Color.fromARGB(204, 0, 0, 0),
                        ],
                        stops: [0.0, 1.0],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 60, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.play_circle_outline,
                            color: mainColor,
                            size: 45,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'MovieOnline',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 35,
                          ),
                          Positioned(
                            left: 17,
                            child: Icon(
                              Icons.circle,
                              size: 13,
                              color: Colors.red,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.5 * 0.8,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomPrimaryButton(text: 'PLAY', onTap: () {}),
                            SizedBox(
                              width: 5,
                            ),
                            CustomSecondaryButton(
                              text: 'TRAILER',
                              onTap: () {},
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        //api only has one image
                        // CarouselIndicator(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //implement this gradient properly
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(204, 0, 0, 0),
                    Color.fromARGB(255, 22, 21, 21).withOpacity(0.0),
                  ],
                  stops: [0.0, 2.0],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Movies',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'see all',
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            //popular moves
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: BlocBuilder<MoviesCubit, MoviesState>(
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
                    return Container(
                      height: 200,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return popularMovies(
                            context,
                            movies[index].title,
                            movies[index].description,
                            movies[index].image,
                            movies[index].id,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          width: 10,
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
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New On Cinemas',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'see all',
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            //new movies
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: BlocBuilder<MoviesCubit, MoviesState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Center(
                      child: SizedBox(
                          height: 40,
                          child: CircularProgressIndicator(color: mainColor)),
                    );
                  } else if (state is LoadedState) {
                    final moviess = state.movies;
                    moviess.shuffle();
                    return Container(
                      height: 200,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return newMovies(
                            context,
                            moviess[index].image,
                            moviess[index].id,
                          );
                        },
                        itemCount: 5,
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          width: 10,
                        ),
                        scrollDirection: Axis.horizontal,
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
            SizedBox(
              height: 14,
            ),
          ],
        ),
      ),
    );
  }
}






//to do
//1. carousel tapable
//2. implement proper loading phase..not just a circular progress indicator