part of 'movie_search_cubit.dart';

abstract class MovieSearchState {}

class MovieSearchInitial extends MovieSearchState {}

class LoadingSearchState extends MovieSearchState {
  @override
  List<Object> get props => [];
}

class LoadedSearchState extends MovieSearchState {
  LoadedSearchState(this.queryMovies);

  final List<MovieModel> queryMovies;

  @override
  List<Object> get props => [queryMovies];
}

class ErrorSearchState extends MovieSearchState {
  @override
  List<Object> get props => [];
}
