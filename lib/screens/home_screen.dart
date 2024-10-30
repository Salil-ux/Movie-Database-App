import 'package:final2/widget/nowplaying_widget.dart';
import 'package:final2/repository/movie_repository.dart';
import 'package:final2/moviebloc/popular_movie_bloc.dart';
import 'package:final2/widget/trending_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constant_color.dart';
import '../moviebloc/movie_bloc.dart';
import '../moviebloc/movie_event.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final movieRepository = MovieRepository();
    return SingleChildScrollView(
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Now Playing',
            style: TextStyle(
              fontSize: 24,
              color: Appcolor.mred,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.56,
            child: BlocProvider(
              create: (context) =>
                  MovieBloc(movieRepository)..add(FetchMovies()),
              child: const MoviePosterScreen(),
            ),
          ),
          // const Text(
          //   'Trending',
          //   style: TextStyle(
          //     fontSize: 24,
          //     color: Colors.redAccent,
          //     fontWeight: FontWeight.w500,
          //   ),
          //   textAlign: TextAlign.left,
          // ),

          const SizedBox(height: 10),
          Text(
            'Trending',
            style: TextStyle(
              fontSize: 24,
              color: Appcolor.mred,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            //height: MediaQuery.of(context).size.height * 0.5,
            child: BlocProvider(
              create: (context) =>
                  PopularMovieBloc(movieRepository)..add(FetchMovies()),
              child: const TrendingScreen(),
            ),
          ),
        ],
      ),
    );
  }
}
