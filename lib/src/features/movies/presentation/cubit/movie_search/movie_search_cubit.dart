import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movieapp/src/features/movies/data/Repository/movie_repository.dart';
import 'package:movieapp/src/features/movies/data/models/movie_model.dart';

part 'movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  final MovieRepository repository;
  MovieSearchCubit({required this.repository}) : super(MovieSearchInitial());

  void getQueriedMovies(
    String queryTerm, {
    String genre = 'all',
    String quality = 'all',
    String orderby = 'desc',
    String sortbyy = 'date_added',
  }) async {
    try {
      //loading state is emitted
      emit(LoadingSearchState());
      //in some filtering cases code below this doesnt' work and it goes to errorstate catch block
      List<MovieModel> queryMovies = await repository.getQueries(
        queryTerm,
        genre: genre,
        quality: quality,
        orderby: orderby,
        sortby: sortbyy,
      );
      print(queryMovies);
      emit(LoadedSearchState(queryMovies));
      print('no error');
    } catch (e) {
      emit(ErrorSearchState());
      print('errrrrrrrrr00rrrrrrrrrrrrrrrro +${e.toString()}');
    }
  }
}
