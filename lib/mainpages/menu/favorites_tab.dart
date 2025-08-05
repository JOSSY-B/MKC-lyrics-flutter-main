import 'package:flutter/material.dart';
import 'package:mkcchoirlyrics/constants/constants.dart';
import 'package:mkcchoirlyrics/mainpages/menu/chords_page.dart';
import 'package:mkcchoirlyrics/mainpages/menu/favorites_songs_page.dart';

class FavoritesTab extends StatefulWidget {
  @override
  _FavoritesTabState createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  final List<Widget> _tabs = [
    FavoriteSongs(),
    ChordsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          backgroundColor: colorPrimary,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Favorites',
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold // 2
                    ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              color: colorPrimary, // Background color for the tab bar
              child: const TabBar(
                labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold), // Adjust the font size here
                labelColor: Colors.white, // Text color for the selected tab
                unselectedLabelColor:
                    Colors.black, // Text color for unselected tabs
                tabs: [
                  Tab(text: 'Songs'),
                  Tab(text: 'Chords'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: _tabs,
        ),
      ),
    );
  }
}
