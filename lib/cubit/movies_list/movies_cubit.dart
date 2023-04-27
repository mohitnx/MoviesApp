import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/data/Repository/movie_repository.dart';
import 'package:movieapp/data/models/movie_model.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MovieRepository repository;
  MoviesCubit({required this.repository}) : super(InitialState()) {
    getMoivesList();
  }

  void getMoivesList() async {
    try {
      ///main kura ko ho
      ////emit garne kura uta listenre haur(blocbuilder/blocconsumer/ etc) le sunira huncha

//so eta bata
//1. emit loadingState is emited...
//2.movies varibale is populated with data from getmoves..which is a class instace of json
//3.loadedState is emited..

//in ui where blocbuilder is listening
//if the state is loading..we show a progress indiactor
//if it is loaded we show the actual json item
//else we show somehting else

//if we remove emitloadingState here...ui build huda we won't get a circualr progress indiator
//as loading state is not emitted...so it cant be listened to in the ui..
      emit(LoadingState());
      final movies = await repository.getMovies();
      emit(LoadedState(movies));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
