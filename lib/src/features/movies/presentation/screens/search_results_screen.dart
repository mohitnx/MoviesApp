// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movieapp/src/features/movies/data/models/movie_model.dart';
import 'package:movieapp/src/features/movies/presentation/cubit/movie_search/movie_search_cubit.dart';
import 'package:movieapp/src/features/movies/presentation/widgets/fitler_widget.dart';

import '../../../../constants/constants.dart';

import '../widgets/popular_movies_list.dart';

class SearchTermResults extends StatefulWidget {
  final TextEditingController searchTerm;
  SearchTermResults({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  @override
  State<SearchTermResults> createState() => _SearchTermResultsState();
}

class _SearchTermResultsState extends State<SearchTermResults> {
  String? filterVal1;
  String? filterVal2;
  String? filterVal3;
  String? filterVal4;

  void onFilterChanged(String val1, String val2, String val3, String val4) {
    context.read<MovieSearchCubit>().getQueriedMovies(
          widget.searchTerm.text.trim(),
          genre: val1,
          quality: val2,
          orderby: val3,
          sortbyy: val4,
        );
    print(val1 + val2 + val3 + val4);
  }

  String searchText = '';
  Timer? debounce;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<MovieSearchCubit>()
        .getQueriedMovies(widget.searchTerm.text.trim());
    print(widget.searchTerm);

//any time text editing controller changes...that is when we type something this is called..
//inside it we first we check if debounce is alreayd active ...if yes then cancel it do noting
//else we put a timer of certain amount...after text editing controller changes, it waits for that time before calling the api call to fetch movies based on the search term
    widget.searchTerm.addListener(() {
      if (debounce?.isActive ?? false) debounce?.cancel();
      debounce = Timer(const Duration(milliseconds: 600), () {
        context
            .read<MovieSearchCubit>()
            .getQueriedMovies(widget.searchTerm.text.trim());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(
          right: 20.0,
          left: 20.0,
          bottom: 10.0,
          top: 40,
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
                controller: widget.searchTerm,
                style: TextStyle(color: secondaryTextColor),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 15),
                  focusedBorder: InputBorder.none,
                  prefixIcon: IconButton(
                    onPressed: () {
                      if (widget.searchTerm.text.isNotEmpty) {
                        context
                            .read<MovieSearchCubit>()
                            .getQueriedMovies(widget.searchTerm.text.trim());

                        print('testtt');
                      } else {
                        print('else  testtt');
                      }
                    },
                    icon: Icon(
                      Icons.search_outlined,
                      color: mainColor,
                    ),
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
            Container(
              padding: EdgeInsets.only(bottom: 2, left: 5, right: 5, top: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: dropdownAreaColor,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilterWidget(
                    searchTerm: widget.searchTerm,
                    selectedItem: 'All',
                    label: 'Genre:',
                    items: genreType,
                    onChanged: (value) {
                      setState(() {
                        filterVal1 = value;
                      });
                      onFilterChanged(
                          filterVal1!, filterVal2!, filterVal3!, filterVal4!);
                    },
                  ),
                  FilterWidget(
                    searchTerm: widget.searchTerm,
                    selectedItem: 'All',
                    label: 'Quality:',
                    items: qualityType,
                    onChanged: (value) {
                      setState(() {
                        filterVal2 = value;
                      });
                      onFilterChanged(
                          filterVal1!, filterVal2!, filterVal3!, filterVal4!);
                    },
                  ),
                  FilterWidget(
                    searchTerm: widget.searchTerm,
                    selectedItem: 'Desc',
                    label: 'Order',
                    items: orderType,
                    onChanged: (value) {
                      setState(() {
                        filterVal3 = value;
                      });
                      onFilterChanged(
                          filterVal1!, filterVal2!, filterVal3!, filterVal4!);
                    },
                  ),
                  FilterWidget(
                    searchTerm: widget.searchTerm,
                    selectedItem: 'Date_added',
                    label: 'Sort',
                    items: sortType,
                    onChanged: (value) {
                      setState(() {
                        filterVal4 = value;
                      });
                      onFilterChanged(
                          filterVal1!, filterVal2!, filterVal3!, filterVal4!);
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<MovieSearchCubit, MovieSearchState>(
                builder: (context, state) {
              if (state is LoadingSearchState) {
                return Center(
                  child: SizedBox(
                    height: 40,
                    child: SpinKitDoubleBounce(color: mainColor),
                  ),
                );
              } else if (state is LoadedSearchState) {
                final queryedList = state.queryMovies;
                if (queryedList.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          'No results for your query.',
                          style: TextStyle(
                            fontSize: 20,
                            color: secondaryTextColor,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Go back',
                              style: TextStyle(color: mainColor),
                            ))
                      ],
                    ),
                  );
                }
                return Expanded(
                  child: SearchTermsDetails(
                    queryMovies: queryedList,
                    searchTerm: widget.searchTerm,
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    'Opps, something went wrong',
                    style: TextStyle(
                      fontSize: 20,
                      color: mainColor,
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

class SearchTermsDetails extends StatefulWidget {
  final TextEditingController searchTerm;
  List<MovieModel> queryMovies;
  SearchTermsDetails({
    Key? key,
    required this.searchTerm,
    required this.queryMovies,
  }) : super(key: key);

  @override
  State<SearchTermsDetails> createState() => SearchTermsDetailsState();
}

class SearchTermsDetailsState extends State<SearchTermsDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              const TextSpan(
                text: 'Results for  ',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 18),
              ),
              TextSpan(
                  text: widget.searchTerm.text + '  ',
                  style: TextStyle(
                      color: mainColor,
                      fontSize: 15,
                      fontStyle: FontStyle.italic)),
              TextSpan(
                text: '[ ${widget.queryMovies.length.toString()} ]',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 18),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: widget.queryMovies.length,
            itemBuilder: (context, index) {
              return popularMoviesVertical(
                context,
                widget.queryMovies[index].title,
                widget.queryMovies[index].description,
                widget.queryMovies[index].image,
                widget.queryMovies[index].genres,
                widget.queryMovies[index].id,
                widget.queryMovies[index].youtubelink ?? 'xBFWMYmm9ro',
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 22,
            ),
          ),
        ),
      ],
    );
  }
}





//sab default value dida error aucha ...cubit ko try catch block le error dincah