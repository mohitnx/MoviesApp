part of 'movie_details_cubit.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {
  @override
  List<Object> get props => [];
}

class LoadingDetailsState extends MovieDetailsState {
  @override
  List<Object> get props => [];
}

class LoadedDetailsState extends MovieDetailsState {
  LoadedDetailsState(this.movie);

  final MovieModel movie;

  @override
  Object get props => [movie];
}

class ErrorDetailsState extends MovieDetailsState {
  @override
  List<Object> get props => [];
}
