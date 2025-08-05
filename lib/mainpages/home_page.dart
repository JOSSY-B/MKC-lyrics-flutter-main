import 'package:flutter/material.dart';
import 'dart:io';

import 'package:mkcchoirlyrics/constants/constants.dart';
import 'package:mkcchoirlyrics/mainpages/album_main.dart';
import 'package:mkcchoirlyrics/mainpages/all_songs.dart';
import 'package:mkcchoirlyrics/mainpages/chords_main.dart';
import 'package:mkcchoirlyrics/mainpages/languages.dart';
import 'package:mkcchoirlyrics/mainpages/menu/about.dart';
import 'package:mkcchoirlyrics/mainpages/menu/contact_us.dart';
import 'package:mkcchoirlyrics/mainpages/menu/favorites_tab.dart';
import 'package:mkcchoirlyrics/mainpages/menu/rate_app.dart';
import 'package:mkcchoirlyrics/mainpages/menu/send_email.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

final String url =
    "https://play.google.com/store/apps/details?id=com.ma.butyam.mkcchoir";
final String iosUrl =
    "https://apps.apple.com/us/app/mkc-choir-aa-mezmur-lyrics/id6499510430";

class HomePageMain extends StatefulWidget {
  @override
  _HomePageMainState createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain> {
  final _dialog = RatingDialog(
    initialRating: 1.0,
    title: const Text(
      'Rating Dialog',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
    message: const Text(
      'Tap a star to set your rating. Review the app so that it will reach more people. Stay blessed!',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15),
    ),
    submitButtonText: 'Submit',
    commentHint: 'comment hint',
    onCancelled: () => print('cancelled'),
    onSubmitted: (response) {
      print('rating: ${response.rating}, comment: ${response.comment}');

      // TODO: add your own logic
      if (response.rating < 3.0) {
        // send their comments to your email or anywhere you wish
        // ask the user to contact you instead of leaving a bad review
      } else {
        _launchUrl();
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBgColor,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'MKC Lyrics',
          style: TextStyle(color: Colors.white, fontFamily: 'Abyssinica'),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/images/cover.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(''),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: colorAccent,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.music_note,
                color: colorAccent,
              ),
              title: Text(
                'Chords',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChordsMain(
                            title: "Chords",
                          )),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.favorite,
                color: colorAccent,
              ),
              title: Text(
                'Favorites',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesTab()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: colorAccent,
              ),
              title: Text(
                'About',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.contact_support,
                color: colorAccent,
              ),
              title: Text(
                'Call',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PhoneNumberList()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.email,
                color: colorAccent,
              ),
              title: Text(
                'Email',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmailSender()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.share,
                color: colorAccent,
              ),
              title: Text(
                'Share App',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                if (Platform.isAndroid) {
                  Share.share('${androidAppLink}', subject: 'MKC Lyrics App');
                } else {
                  Share.share('${iosAppLink}', subject: 'MKC Lyrics App');
                }
              },
            ),
            ListTile(
              leading: Icon(
                Icons.reviews,
                color: colorAccent,
              ),
              title: Text(
                'Rate',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) => _dialog,
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02,
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.04,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/main_icon.png',
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.6,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllSongs(title: 'All Songs'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.03,
                        ),
                        textStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontFamily: 'Abyssinica',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text(
                        'All Songs',
                        style: TextStyle(color: colorPrimary),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AlbumMain()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.03,
                        ),
                        textStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontFamily: 'Abyssinica',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text(
                        'Albums',
                        style: TextStyle(color: colorPrimary),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FavoritesTab()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.03,
                        ),
                        textStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontFamily: 'Abyssinica',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text(
                        'Favorites',
                        style: TextStyle(color: colorPrimary),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Languages()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.03,
                        ),
                        textStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontFamily: 'Abyssinica',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text(
                        'Languages',
                        style: TextStyle(color: colorPrimary),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center it instead of spaceEvenly
              children: [
                SizedBox(
                  width: 200, // Set a fixed width (adjust as needed)
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChordsMain(title: 'Chords'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.03,
                        ),
                        textStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontFamily: 'Abyssinica',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text(
                        'Chords',
                        style: TextStyle(color: colorPrimary),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future _launchUrl() async {
  if (Platform.isAndroid) {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  } else {
    final Uri _url1 = Uri.parse(iosUrl);
    if (!await launchUrl(_url1)) {
      throw Exception('Could not launch $_url1');
    }
  }
}
