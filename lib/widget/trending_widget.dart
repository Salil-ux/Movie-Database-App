import 'package:final2/moviebloc/popular_movie_bloc.dart';
import 'package:final2/screens/selectedmovie_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constant_color.dart';
import '../moviebloc/movie_event.dart';
import '../moviebloc/movie_state.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void refresh() {
      context.read<PopularMovieBloc>().add(FetchMovies());
    }

    return BlocBuilder<PopularMovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MovieError) {
          return Center(
            child: ElevatedButton(
              onPressed: refresh,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.red,
                  foregroundColor: Appcolor.white),
              child: const Text("Reload"),
            ),
          );
        } else if (state is MovieLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "    Trending",
              //   style: TextStyle(
              //     fontSize: 24,
              //     color: Appcolor.red,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PopularScreen(
                                  selectedMovie: movie,
                                  hero: 'trnding-${movie.id}',
                                  initialIndex: state.movies.indexOf(movie),
                                  movies: state.movies,
                                ),
                              ),
                            );
                          },
                          child: Hero(
                            tag: 'trnding-${movie.id}',
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: 300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(movie.title,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const Center(child: Text('No movies found.'));
      },
    );
  }
}
