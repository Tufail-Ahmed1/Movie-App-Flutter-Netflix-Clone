import 'package:flutter/material.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/screens/search_screen.dart';
import 'package:movie_app/screens/more_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});



  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: SizedBox(
            height: 70,
            child:  TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(Icons.search),
                  text: 'Search',
                ),
                Tab(
                  icon: Icon(Icons.photo_library_outlined),
                  text: 'New &Hot',
                ),
              ],
              indicatorColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
            ),
          ),
          body:  TabBarView(
              children: [
                HomeScreen(),
                SearchScreen(),
                MoreScreen(),
              ]
          ),
        ),
    );
  }
}
