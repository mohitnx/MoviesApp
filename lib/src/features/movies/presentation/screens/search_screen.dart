import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:movieapp/src/constants/constants.dart';

import 'package:movieapp/src/features/movies/presentation/screens/search_results_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/movies_list/movies_cubit.dart';
import '../widgets/popular_movies_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTermController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            right: 20.0.w,
            left: 20.0.w,
            bottom: 10.h,
            top: 80.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 32.sp),
              ),
              SizedBox(
                height: 25.sp,
              ),
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(212, 12, 10, 20),
                    spreadRadius: 4.r,
                    blurRadius: 30.r,
                  ),
                ]),
                child: TextFormField(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchTermResults(
                                searchTerm: searchTermController,
                              )),
                    );
                  },
                  autofocus: true,
                  controller: searchTermController,
                  style: TextStyle(color: secondaryTextColor),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 15.h),
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
              SizedBox(
                height: 30.h,
              ),
              Text(
                'Popular Search',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 18.sp),
              ),
              SizedBox(
                height: 24.h,
              ),
              BlocBuilder<MoviesCubit, MoviesState>(
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
                            movies[index].youtubelink!,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          height: 22.h,
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
      ),
    );
  }
}
