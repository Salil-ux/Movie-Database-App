// import 'dart:math';
//
// import 'package:final2/popular_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'nowplaying_widget.dart';
// import 'movie.dart';
// import 'movie_bloc.dart';
// import 'popular_movie_bloc.dart';
// import 'movie_repository.dart';
// import 'movie_event.dart';
// import 'movie_state.dart';
// import 'selectedmovie_screen.dart';
// import 'settings_screen.dart';
// import 'navigation_bloc.dart';
// import 'navigation_event.dart';
// import 'navigation_state.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final movieRepository = MovieRepository();
//
//     return MaterialApp(
//       title: 'Movie App',
//       theme: ThemeData.dark(),
//       //home: first(),
//       home: MultiBlocProvider(
//         providers: [
//           BlocProvider(
//             create: (context) => MovieBloc(movieRepository)..add(FetchMovies()),
//           ),
//           BlocProvider(
//             create: (context) =>
//                 PopularMovieBloc(movieRepository)..add(FetchMovies()),
//           ),
//           BlocProvider(create: (context) => NavigationBloc()),
//         ],
//         child: HomeScreen(),
//       ),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//
//     context.read<MovieBloc>().add(FetchMovies());
//     context.read<PopularMovieBloc>().add(FetchMovies());
//   }
//
//   void _refresh() {
//     context.read<PopularMovieBloc>().add(FetchMovies());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<NavigationBloc, NavigationState>(
//       builder: (context, navigationState) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text(
//               'Movie DB',
//               selectionColor: Colors.redAccent,
//             ),
//             backgroundColor: Colors.red,
//           ),
//           body: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Column(
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     'Now Playing', // Your title text
//                     style: TextStyle(
//                       fontSize: 24, // Font size
//                       fontWeight: FontWeight.bold, // Font weight
//                     ),
//                   ),
//                 ),
//                 _pages[navigationState.selectedIndex],
//                 BlocBuilder<PopularMovieBloc, MovieState>(
//                   builder: (context, state) {
//                     if (state is MovieLoading) {
//                       return Center(child: CircularProgressIndicator());
//                     } else if (state is MovieError) {
//                       return Center(
//                           child: SizedBox(
//                         height: 50,
//                         width: 150,
//                         child: ElevatedButton(
//                           onPressed: _refresh,
//                           child: Text("Reload"),
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.redAccent),
//                         ),
//                       ));
//                     } else if (state is MovieLoaded) {
//                       return SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.5,
//                         // color: Colors.grey,
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           scrollDirection: Axis.horizontal,
//                           itemCount: state.movies.length,
//                           itemBuilder: (context, index) {
//                             final movie = state.movies[index];
//                             return Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 10, right: 1, top: 10),
//                               child: Column(
//                                 children: [
//                                   const Text(
//                                     'Trending', // Your title text
//                                     style: TextStyle(
//                                       color: Colors.yellow,
//                                       // fontFamily: 'SharpSans',
//                                       fontSize: 24, // Font size
//                                       fontWeight:
//                                           FontWeight.w500, // Medium weight
//                                       // Font weight
//                                     ),
//                                   ),
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => PopularScreen(
//                                               selectedMovie: movie,
//                                               hero:
//                                                   'now_playing-${movie.id}'), // Pass the selected movie
//                                         ),
//                                       );
//                                     },
//                                     child: Hero(
//                                       tag: 'now_playing-${movie.id}',
//                                       child: Image.network(
//                                         'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 0.3,
//                                         width: 300,
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 2),
//                                   Text(movie.title,
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold)),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     }
//                     return const Center(child: Text('No movies found.'));
//                   },
//                 ),
//               ],
//             ),
//           ),
//           bottomNavigationBar: BottomNavigationBar(
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//               BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Popular'),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.settings), label: 'Settings'),
//             ],
//             currentIndex: navigationState.selectedIndex,
//             onTap: (index) {
//               switch (index) {
//                 case 0:
//                   context.read<NavigationBloc>().add(NavigateToHome());
//                   break;
//                 case 1:
//                   context.read<NavigationBloc>().add(NavigateToPopular());
//                   break;
//                 case 2:
//                   context.read<NavigationBloc>().add(NavigateToSettings());
//                   break;
//               }
//             },
//           ),
//         );
//       },
//     );
//   }
//
//   final List<Widget> _pages = [
//     MoviePosterScreen(),
//     Reload(),
//     SettingsScreen(),
//   ];
// }

// import 'package:final2/popular_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'home_screen.dart';
// import 'navigation_bloc.dart';
// import 'navigation_event.dart';
// import 'navigation_state.dart';
// import 'nowplaying_widget.dart';
// import 'settings_screen.dart';
// import 'selectedmovie_screen.dart'; // Assuming you still want a popular screen
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Movie App',
//       theme: ThemeData.dark(),
//       home: BlocProvider(
//         create: (context) => NavigationBloc(),
//         child: HomeScreen(),
//       ),
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<NavigationBloc, NavigationState>(
//       builder: (context, navigationState) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('Movie DB'),
//             backgroundColor: Colors.red,
//           ),
//           body: _pages[navigationState.selectedIndex],
//           bottomNavigationBar: BottomNavigationBar(
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//               BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Popular'),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.settings), label: 'Settings'),
//             ],
//             currentIndex: navigationState.selectedIndex,
//             onTap: (index) {
//               switch (index) {
//                 case 0:
//                   context.read<NavigationBloc>().add(NavigateToHome());
//                   break;
//                 case 1:
//                   context.read<NavigationBloc>().add(NavigateToPopular());
//                   break;
//                 case 2:
//                   context.read<NavigationBloc>().add(NavigateToSettings());
//                   break;
//               }
//             },
//           ),
//         );
//       },
//     );
//   }
//
//   final List<Widget> _pages = [
//     const Home(),
//     const Reload(), // Replace with your implementation if necessary
//     SettingsScreen(),
//   ];
// }
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
