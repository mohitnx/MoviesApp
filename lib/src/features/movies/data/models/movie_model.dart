// ignore_for_file: public_member_api_docs, sort_constructors_first
class MovieModel {
  int id;
  int? releaseYear;
  String? rating;
  String title;
  String image;
  String description;
  String? sharelink;
  String? youtubelink;
  int? queryLength;
  String? torrentLink;
  var genres;
  var cast;

  MovieModel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.genres,
    this.releaseYear,
    this.cast,
    this.sharelink,
    this.rating,
    this.youtubelink,
    this.torrentLink,
    this.queryLength,
  });
}
