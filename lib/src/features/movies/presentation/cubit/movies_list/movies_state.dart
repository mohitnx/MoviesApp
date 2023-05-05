part of 'movies_cubit.dart';

abstract class MoviesState {}

class InitialState extends MoviesState {
  @override
  List<Object> get props => [];
}

class LoadingState extends MoviesState {
  @override
  List<Object> get props => [];
}

class LoadedState extends MoviesState {
  LoadedState(this.movies);

  final List<MovieModel> movies;

  @override
  List<Object> get props => [movies];
}

class ErrorState extends MoviesState {
  @override
  List<Object> get props => [];
}
