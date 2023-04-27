import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/Repository/movie_repository.dart';
import '../../data/models/movie_model.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieRepository repository;

  MovieDetailsCubit({required this.repository}) : super(MovieDetailsInitial());
  void getMovieDetail(int movieId) async {
    try {
      emit(LoadingDetailsState());
      final movie = await repository.getMovieDetails(movieId: movieId);
      emit(LoadedDetailsState(movie));
    } catch (e) {
      emit(ErrorDetailsState());
    }
  }
}
