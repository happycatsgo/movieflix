class Genre {
  int? id;
  String? name;

  Genre({this.id, this.name});

  Genre.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class MovieDetailModel {
  final String title, poster, overview;
  final double vote;
  final int id;
  List<Genre>? genres;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        poster = json['poster_path'],
        vote = json['vote_average'],
        overview = json['overview'],
        id = json['id'] {
    if (json['genres'] != null) {
      genres = <Genre>[];
      json['genres'].forEach((v) {
        genres!.add(Genre.fromJson(v));
      });
    }
  }
}
