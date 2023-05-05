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
          youtubelink: temp['data']['movies'][i]['yt_trailer_code'],
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
  Future getQueries(
    String queryTerm, {
    String genre = 'all',
    String quality = 'all',
    String orderby = 'desc',
    String sortby = 'date_added',
  }) async {
    List<MovieModel> queryMovies = [];
    try {
      final url =
          'https://yts.mx/api/v2/list_movies.json?query_term=$queryTerm&genre=$genre&quality=$quality&order_by=$orderby&sort_by=$sortby';
      //genre=all, no filter, else genre=genre

      final response = await client.get(url);
      final temp = response.data;
      int length = temp['data']['movie_count'];
      print(length);
      if (length < 20) {
        for (int i = 0; i < length; i++) {
          final data = MovieModel(
            queryLength: length,
            id: temp['data']['movies'][i]['id'],
            title: temp['data']['movies'][i]['title'],
            description: temp['data']['movies'][i]['description_full'],
            image: temp['data']['movies'][i]['large_cover_image'],
            genres: temp['data']['movies'][i]['genres'],
            youtubelink: temp['data']['movies'][i]['yt_trailer_code'],
          );
          queryMovies.add(data);
        }
      } else {
        for (int i = 0; i < 20; i++) {
          final data = MovieModel(
            queryLength: 20,
            id: temp['data']['movies'][i]['id'],
            title: temp['data']['movies'][i]['title'],
            description: temp['data']['movies'][i]['description_full'],
            image: temp['data']['movies'][i]['large_cover_image'],
            genres: temp['data']['movies'][i]['genres'],
            youtubelink: temp['data']['movies'][i]['yt_trailer_code'],
          );
          queryMovies.add(data);
        }
      }

      //querMovies has the moviss...so this function retunrs a list of movidemodel
      print(queryMovies.length);
      return queryMovies;
    } on DioError catch (e) {
      print('what error');
      if (e.response != null) {
        print(e);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    }
  }
///////////////////////////////////////////////////////////////////

  Future getMovieDetails({required int movieId, required String ytLink}) async {
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
        sharelink: temp['data']['movie']['url'],
        torrentLink: temp['data']['movie']['torrents'][0]['url'],
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
