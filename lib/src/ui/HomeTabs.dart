import 'package:flutter/material.dart';
import 'package:my_shows/src/ui/AllMovies.dart';
import 'package:my_shows/src/ui/PopuularMovies.dart';
import 'package:my_shows/src/utils/constants.dart';

class HomeTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Color(Constants.ThemeBgColor),
          body: new TabBarView(
            children: <Widget>[
              AllMovies('My Movies'),
              PopularMovies('Popular Movies'),
              Scaffold(
                appBar: AppBar(
                  title: Text('Setting'),
                  backgroundColor: Color(Constants.ThemeBgColor),
                ),
                body: Container(
                  color: Color(Constants.ThemeColor),
                ),
              )
            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.movie),
                text: 'Upcoming',
              ),
              Tab(
                icon: Icon(Icons.movie),
                text: 'Popular',
              ),
              Tab(
                icon: Icon(Icons.settings),
                text: 'Setting',
              ),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.blueGrey,
            indicatorColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
