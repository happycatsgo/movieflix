import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/screens/detail_screen.dart';
import 'package:movieflix/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieModel>> popularMovieList =
      ApiService.getMovies('popular');
  final Future<List<MovieModel>> nowMovieList =
      ApiService.getMovies('now-playing');
  final Future<List<MovieModel>> comingMovieList =
      ApiService.getMovies('coming-soon');
  static const String imgBaseUrl = "https://image.tmdb.org/t/p/w500/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              Text("Popular Movies",
                  style: Theme.of(context).textTheme.displayLarge),
              FutureBuilder(
                future: popularMovieList,
                builder: (context, snapshot) {
                  return SizedBox(
                    height: 235,
                    child: snapshot.hasData
                        ? makePopularMovies(snapshot)
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  );
                },
              ),
              Text("Now in Cinemas",
                  style: Theme.of(context).textTheme.displayLarge),
              FutureBuilder(
                future: nowMovieList,
                builder: (context, snapshot) {
                  return SizedBox(
                    height: 280,
                    child: snapshot.hasData
                        ? makePosterTitles(snapshot)
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  );
                },
              ),
              Text("Coming soon",
                  style: Theme.of(context).textTheme.displayLarge),
              FutureBuilder(
                future: comingMovieList,
                builder: (context, snapshot) {
                  return SizedBox(
                    height: 280,
                    child: snapshot.hasData
                        ? makePosterTitles(snapshot)
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView makePopularMovies(AsyncSnapshot<List<MovieModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              fullscreenDialog: false,
              builder: (context) => DetailScreen(movie: snapshot.data![index]),
            ),
          );
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.network(
            "$imgBaseUrl/${snapshot.data![index].backdrop}",
          ),
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(width: 15),
    );
  }

  ListView makePosterTitles(AsyncSnapshot<List<MovieModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemBuilder: (context, index) => SizedBox(
        width: 120,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                fullscreenDialog: false,
                builder: (context) =>
                    DetailScreen(movie: snapshot.data![index]),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(
                  "$imgBaseUrl/${snapshot.data![index].poster}",
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                snapshot.data![index].title,
                style: Theme.of(context).textTheme.displaySmall,
                softWrap: true,
              ),
            ],
          ),
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(width: 15),
    );
  }
}
