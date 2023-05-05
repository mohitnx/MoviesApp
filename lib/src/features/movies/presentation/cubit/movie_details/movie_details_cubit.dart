import 'package:bloc/bloc.dart';

import 'package:movieapp/src/features/movies/data/Repository/movie_repository.dart';
import 'package:movieapp/src/features/movies/data/models/movie_model.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieRepository repository;

  MovieDetailsCubit({required this.repository}) : super(MovieDetailsInitial());
  void getMovieDetail(int movieId, String ytLink) async {
    try {
      emit(LoadingDetailsState());
      final movie =
          await repository.getMovieDetails(movieId: movieId, ytLink: ytLink);
      print('-----------------' + ytLink);
      emit(LoadedDetailsState(movie));
    } catch (e) {
      emit(ErrorDetailsState());
    }
  }
}
