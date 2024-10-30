import 'package:final2/screens/popular_screen.dart';
import 'package:final2/screens/search_screen.dart';
import 'package:final2/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constant_color.dart';
import '../widget/popup.dart';
import 'home_screen.dart';
import '../navigationbloc/navigation_bloc.dart';
import '../navigationbloc/navigation_event.dart';
import '../navigationbloc/navigation_state.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, navigationState) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/img_1.png",
                    fit: BoxFit.cover,
                    width: 30,
                    height: 80,
                  ),
                ),
              )
            ],
            title: const Text('Movie DB'),
            backgroundColor: Appcolor.mred,
            leading: TextButton(
                onPressed: () {
                  showAlertDialog(context);
                },
                child: const Icon(Icons.logout_outlined)),
          ),
          body: _pages[navigationState.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Popular'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
            ],
            selectedItemColor: Appcolor.mred,
            unselectedItemColor: Colors.grey,
            currentIndex: navigationState.selectedIndex,
            onTap: (index) {
              switch (index) {
                case 0:
                  context.read<NavigationBloc>().add(NavigateToHome());
                  break;
                case 1:
                  context.read<NavigationBloc>().add(NavigateToPopular());
                  break;
                case 2:
                  context.read<NavigationBloc>().add(NavigateToSettings());
                  break;
                case 3:
                  context.read<NavigationBloc>().add(NavigateToSearch());
                  break;
//
              }
            },
          ),
        );
      },
    );
  }

  final List<Widget> _pages = [
    const Home(),
    const Reload(),
    const SettingsScreen(),
    const MovieSearchPage()
  ];

  HomeScreen({super.key});
}
