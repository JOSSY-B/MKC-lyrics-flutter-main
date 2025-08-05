import 'package:mkcchoirlyrics/model/all_songs.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;

Future<List<AllSongsModel>> getLanguageSongs() async {
  final jsondata =
      await rootBundle.rootBundle.loadString('assets/languages_song.json');
  final song = json.decode(jsondata) as List<dynamic>;
  return song.map((json) => AllSongsModel.fromJson(json)).toList();

  // return artists.map((e) => ArtistModel.fromJson(e)).toList();
}
