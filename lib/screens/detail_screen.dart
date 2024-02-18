import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_detail_model.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/services/api_service.dart';

class DetailScreen extends StatelessWidget {
  final MovieModel movie;
  static const String imgBaseUrl = "https://image.tmdb.org/t/p/w500/";
  late final Future<MovieDetailModel> movieDetail;

  DetailScreen({super.key, required this.movie})
      : movieDetail = ApiService.getDetail(movie.id);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("$imgBaseUrl/${movie.poster}"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          titleSpacing: -10,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          title: Text("Back to list",
              style: Theme.of(context).textTheme.bodyMedium),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: FutureBuilder(
              future: movieDetail,
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 200),
                          Text(snapshot.data!.title,
                              style: Theme.of(context).textTheme.bodyLarge),
                          StarDisplay(value: snapshot.data!.vote.round() / 2),
                          Text(makeGenreString(snapshot.data!.genres),
                              style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(
                            height: 20,
                          ),
                          Text("Storyline",
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text(snapshot.data!.overview,
                              style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 200),
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          width: 300,
          child: FloatingActionButton(
            onPressed: () {
              print('Buy ticket clicked');
            },
            backgroundColor: Colors.yellow,
            child: Text('Buy ticket',
                style: Theme.of(context).textTheme.displayMedium),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class StarDisplay extends StatelessWidget {
  final double value; // 별점 값을 저장하는 변수
  const StarDisplay({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    // 별점을 나타내기 위한 아이콘 리스트를 생성합니다.
    List<Widget> stars = List.generate(5, (index) {
      // index가 현재 별점보다 작으면 채워진 별을 반환합니다.
      if (index < value) {
        // 반쪽 별을 표시해야 하는 경우를 처리합니다.
        if (index + 0.5 >= value) {
          return const Icon(Icons.star_half, color: Colors.yellow);
        }
        return const Icon(Icons.star, color: Colors.yellow);
      } else {
        // 나머지 경우는 빈 별을 반환합니다.
        return const Icon(Icons.star_border, color: Colors.yellow);
      }
    });

    return Row(
      mainAxisSize: MainAxisSize.min, // 별들이 필요한 만큼의 공간만 차지하도록 설정합니다.
      children: stars,
    );
  }
}

String makeGenreString(List<Genre>? genres) {
  return (genres == null)
      ? ''
      : genres.map((genre) => genre.name ?? '').join(', ');
}
