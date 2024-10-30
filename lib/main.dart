import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final movieRepository = MovieRepository();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme()),
      // home: MultiBlocProvider(
      //   providers: [
      //     BlocProvider(create: (context) => NavigationBloc()),
      //     BlocProvider(
      //         create: (context) =>
      //             PopularMovieBloc(movieRepository)..add(FetchMovies())),
      //     BlocProvider(
      //         create: (context) =>
      //             MovieBloc(movieRepository)..add(FetchMovies())),
      //   ],
      home: const HomePage(),
    );
  }
}
