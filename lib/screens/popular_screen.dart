import 'package:flutter/material.dart';
import 'package:final2/moviebloc/popular_movie_bloc.dart';
import 'package:final2/screens/selectedmovie_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constant_color.dart';
import '../moviebloc/movie_event.dart';
import '../moviebloc/movie_state.dart';

class Reload extends StatefulWidget {
  const Reload({super.key});

  @override
  State<Reload> createState() => _ReloadState();
}

class _ReloadState extends State<Reload> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch movies when dependencies change
    context.read<PopularMovieBloc>().add(FetchMovies());
  }

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
                  backgroundColor: Appcolor.nred,
                  foregroundColor: Appcolor.white),
              child: const Text("Reload"),
            ),
          );
        } else if (state is MovieLoaded) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.6,
            ),
            itemCount: state.movies.length,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              return Container(
                margin: const EdgeInsets.all(1.0),
                width: 500,
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PopularScreen(
                              selectedMovie: movie,
                              hero: 'reload-${movie.id}',
                              initialIndex: state.movies.indexOf(movie),
                              movies: state.movies,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'reload-${movie.id}',
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                          // height: 300,
                          // width: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(movie.title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            },
          );
        }
        return const Center(child: Text('No movies found.'));
      },
    );
  }
}
