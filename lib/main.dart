import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mkcchoirlyrics/database_hive/song_db.dart';
import 'package:mkcchoirlyrics/mainpages/home_page.dart';
import 'package:mkcchoirlyrics/splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(SongsDbAdapter());

  await Hive.openBox<SongsDb>('song');
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePageMain(),
    );
  }
}
