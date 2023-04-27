import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/movie_model.dart';

class MovieRepository {
  final Dio client;

  MovieRepository(this.client);

  Future getMovies() async {
    List<MovieModel> movies = [];
    try {
      final url = 'https://yts.mx/api/v2/list_movies.json?limit=40';

      final response = await client.get(url);
      final temp = response.data;
      print(temp);

      for (int i = 0; i < 20; i++) {
        final data = MovieModel(
          id: temp['data']['movies'][i]['id'],
          title: temp['data']['movies'][i]['title'],
          description: temp['data']['movies'][i]['description_full'],
          image: temp['data']['movies'][i]['large_cover_image'],
          genres: temp['data']['movies'][i]['genres'],
        );
        movies.add(data);
      }

      return movies;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

///////////////////////////////////////////////////////////////////

  Future getMovieDetails({required int movieId}) async {
    try {
      final url =
          'https://yts.mx/api/v2/movie_details.json?movie_id=$movieId&with_cast=true';

      final response = await client.get(url);
      final temp = response.data;
      print(temp);

      final data = MovieModel(
        id: temp['data']['movie']['id'],
        title: temp['data']['movie']['title'],
        description: temp['data']['movie']['description_full'],
        image: temp['data']['movie']['large_cover_image'],
        genres: temp['data']['movie']['genres'],
        cast: temp['data']['movie']['cast'],
        releaseYear: temp['data']['movie']['year'],
        rating: temp['data']['movie']['mpa_rating'],
      );
      return data;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    }
  }
}
