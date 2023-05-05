import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movieapp/src/constants/constants.dart';

import 'package:movieapp/src/features/movies/presentation/screens/movies_list.dart';
import 'package:movieapp/src/features/movies/presentation/widgets/custom_button.dart';

import 'package:movieapp/src/features/movies/presentation/widgets/new_movies_list.dart';
import 'package:movieapp/src/features/movies/presentation/widgets/popular_movies_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/movies_list/movies_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.52,
                    child: BlocBuilder<MoviesCubit, MoviesState>(
                      builder: (context, state) {
                        if (state is LoadingState) {
                          return Center(
                            child: SpinKitDoubleBounce(color: mainColor),
                          );
                        } else if (state is LoadedState) {
                          final movie = state.movies;
                          final randomIndex = Random().nextInt(19);
                          return CachedNetworkImage(
                            imageUrl: movie[randomIndex].image,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Image.network(
                              'https://images.unsplash.com/photo-1628155930542-3c7a64e2c833?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bm8lMjBpbWFnZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60',
                              fit: BoxFit.cover,
                            ),
                            placeholder: (context, url) =>
                                SpinKitWaveSpinner(color: mainColor),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          const Color.fromARGB(255, 158, 158, 158)
                              .withOpacity(0.0),
                          const Color.fromARGB(204, 0, 0, 0),
                        ],
                        stops: const [0.0, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.5 * 0.8,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 30.h,
                        horizontal: 15.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomPrimaryButton(text: 'PLAY', onTap: () {}),
                              const SizedBox(
                                width: 5,
                              ),
                              CustomSecondaryButton(
                                text: 'TRAILER',
                                onTap: () async {
                                  print('trailer button');
                                  await launchUrl(
                                    Uri.parse(
                                        'https://www.youtube.com/watch?v=vJJYI67RXf4'),
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 60.h, horizontal: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.play_circle_outline,
                              color: mainColor,
                              size: 45.sp,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'MovieOnline',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
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
                              size: 35.sp,
                            ),
                            Positioned(
                              left: 17.w,
                              child: Icon(
                                Icons.circle,
                                size: 13.sp,
                                color: Colors.red,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Movies',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'see all',
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 16.sp,
                        ),
                      ),
                      onPressed: () {
                        //if it is popilar list then we define one range for movies list
                        //else then another range for movies list...just like we have done here in the home page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MoviesList(
                                    isPopularList: true,
                                  )),
                        );
                      },
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
                          height: 40.h,
                          child: SpinKitDoubleBounce(color: mainColor),
                        ),
                      );
                    } else if (state is LoadedState) {
                      //we have a list of 40 moveis..we shuffle evertime and show only 5 movies
                      //if the user clicks see all then only we show the list of all the moves
                      //done this because the api to get popular moveis needs login and most other movie apis are blocked
                      final temp = state.movies;
                      final movies = temp.sublist(0, 19);
                      movies.shuffle();
                      return SizedBox(
                        height: 200.h,
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
                              movies[index].youtubelink!,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                            width: 10.w,
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
                padding: EdgeInsets.symmetric(horizontal: 13.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New On Cinemas',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'see all',
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 16.sp,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MoviesList(
                                    isPopularList: false,
                                  )),
                        );
                      },
                    ),
                  ],
                ),
              ),
              //new movies
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w),
                child: BlocBuilder<MoviesCubit, MoviesState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return Center(
                        child: SizedBox(
                          height: 40.h,
                          child: SpinKitDoubleBounce(color: mainColor),
                        ),
                      );
                    } else if (state is LoadedState) {
                      final moviess = state.movies;
                      moviess.shuffle();
                      return Container(
                        height: 200.h,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return newMovies(
                              context,
                              moviess[index].image,
                              moviess[index].id,
                              moviess[index].youtubelink!,
                            );
                          },
                          itemCount: 5,
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                            width: 10.w,
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
                height: 14.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}






//to do
//1. carousel tapable
//2. implement proper loading phase..not just a circular progress indicator