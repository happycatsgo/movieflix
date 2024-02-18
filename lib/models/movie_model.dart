class MovieModel {
  final String title, poster, backdrop;
  final int id;

  MovieModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        poster = json['poster_path'],
        backdrop = json['backdrop_path'],
        id = json['id'];
}
