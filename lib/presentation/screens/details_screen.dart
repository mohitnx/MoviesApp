// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movieapp/cubit/movie_details/movie_details_cubit.dart';
import 'package:movieapp/cubit/movies_list/movies_cubit.dart';
import 'package:movieapp/presentation/widgets/custom_button.dart';

import '../../constants.dart';

class DetailsScreen extends StatefulWidget {
  int movieId;
  DetailsScreen({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MovieDetailsCubit>().getMovieDetail(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          if (state is LoadingDetailsState) {
            return Center(
              child: CircularProgressIndicator(color: mainColor),
            );
          } else if (state is LoadedDetailsState) {
            final movie = state.movie;
            return DescriptionBody(
              description: movie.description,
              cast: movie.cast ?? [],
              genre: movie.genres ?? [],
              image: movie.image,
              rating: movie.rating ?? 'E',
              releasedYear: movie.releaseYear ?? 0000,
              title: movie.title,
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

class DescriptionBody extends StatefulWidget {
  String title;
  List cast;
  String rating;
  String description;
  String image;
  List genre;
  int releasedYear;

  DescriptionBody({
    Key? key,
    required this.title,
    required this.cast,
    required this.rating,
    required this.description,
    required this.image,
    required this.genre,
    required this.releasedYear,
  }) : super(key: key);

  @override
  State<DescriptionBody> createState() => _DescriptionBodyState();
}

class _DescriptionBodyState extends State<DescriptionBody> {
  @override
  Widget build(BuildContext context) {
    shareFunction() {
      print('share this');
    }

    downloadFunction() {
      print('downlaod this');
    }

    trailerFunction() {
      print('view this');
    }

    //cast is a list<map> at first extracting the strings from the map and
    //putting them into a new list<String>
    //then mappign throught the new list to generate text widget with cast members
    List tempValues = [];
    widget.cast.forEach((element) {
      tempValues.add(element['name'].toString());
    });

    return Column(
      children: [
        Stack(
          children: [
            Container(
              child: Image.network(
                widget.image,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.52,
                fit: BoxFit.fill,
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
                      Color.fromARGB(242, 0, 0, 0),
                    ],
                    stops: [0.0, 1.0],
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.20,
              left: MediaQuery.of(context).size.width * 0.40,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.play_circle_outline_sharp,
                  color: Colors.white38,
                  size: 60,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 60, horizontal: 15),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: mainColor,
                  size: 28,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width * 0.64,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title + ' [${widget.releasedYear.toString()}]',
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 33),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //runtime is not given in api call so static data
                        Text(
                          '1h 20m',
                          style: TextStyle(
                              color: secondaryTextColor, fontSize: 14),
                        ),
                        SizedBox(
                          width: 9,
                        ),
                        Container(
                          color: mainColor,
                          padding: const EdgeInsets.all(3),
                          child: const Text(
                            ' HD ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        children: widget.genre.map((var item) {
                          return Row(
                            children: [
                              Text(
                                item + ' ',
                                maxLines: 1,
                                style: TextStyle(
                                    color: secondaryTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Center(
                                child: Icon(
                                  Icons.circle,
                                  color: mainColor,
                                  size: 5,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 10,
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(204, 0, 0, 0),
                Color.fromARGB(255, 46, 29, 29).withOpacity(0.0),
              ],
              stops: [0.0, 2.0],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Divider(
            thickness: 0.14,
            color: mainColor,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            verticalButton(
                Icons.date_range_outlined, 'Trailer', trailerFunction),
            //Vertical divider didn't show by default so had to wrap it in contaier

            SizedBox(
              height: 80,
              child: Row(
                children: [
                  VerticalDivider(
                    color: mainColor,
                    thickness: 0.14,
                  ),
                ],
              ),
            ),
            verticalButton(Icons.file_download, 'Download', downloadFunction),
            SizedBox(
              height: 80,
              child: Row(
                children: [
                  VerticalDivider(
                    color: mainColor,
                    thickness: 0.14,
                  ),
                ],
              ),
            ),
            verticalButton(Icons.share, 'Share', shareFunction),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Divider(
            thickness: 0.14,
            color: mainColor,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    print(widget.cast);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      widget.description,
                      style: TextStyle(
                          color: secondaryTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        'Cast:  ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .80,
                        child: Wrap(
                          children: tempValues.map((var item) {
                            return Text(
                              item + ', ',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                //director name not provided so used static data
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        'Director:  ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Martin Tarantino',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget verticalButton(icon, label, onpressed) {
  return InkWell(
    onTap: () {
      onpressed;
    },
    child: Column(
      children: [
        Icon(
          icon,
          color: mainColor,
          size: 40,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: TextStyle(color: mainColor, fontSize: 13),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
