import 'package:flutter/material.dart';
import 'package:mkcchoirlyrics/constants/constants.dart';
import 'package:mkcchoirlyrics/mainpages/all_songs.dart';
import 'package:mkcchoirlyrics/mainpages/languages_songs_list.dart';

class Languages extends StatefulWidget {
  @override
  _LanguagesState createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  List<CountryItem> countries = [
    CountryItem('ኦሮምኛ', 'or'),
    CountryItem('ትግሪኛ', 'tig'),
    CountryItem('ሃዲይኛ', 'had'),
    CountryItem('ጉራጊኛ', 'gur'),
    CountryItem('ወላይትኛ', 'wol'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBgColor,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'ቋንቋዎች',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GridView.count(
        crossAxisCount: MediaQuery.of(context).size.width > 600
            ? 4
            : 2, // Adjust the cross axis count based on screen width
        padding: EdgeInsets.all(16.0),
        childAspectRatio: MediaQuery.of(context).size.width > 600
            ? 0.5
            : 1.2, // Adjust the aspect ratio based on screen width
        children: countries,
      ),
    );
  }
}

class CountryItem extends StatelessWidget {
  final String languageName;
  final String code;

  CountryItem(this.languageName, this.code);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LanguagesSongList(title: languageName, album_id: code)),
        );
      },
      child: Card(
        elevation: 3.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lyrics,
              color: colorAccent,
              size: MediaQuery.of(context).size.width > 600
                  ? 70
                  : 50, // Adjust icon size based on screen width
            ),
            SizedBox(height: 8),
            Text(
              languageName,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 600 ? 30 : 24,
                  fontWeight: FontWeight
                      .bold), // Adjust text size based on screen width
            ),
          ],
        ),
      ),
    );
  }
}
