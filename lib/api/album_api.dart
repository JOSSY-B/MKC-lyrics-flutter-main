import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import 'package:mkcchoirlyrics/model/album.dart';

Future<List<Album>> getAlbums() async {
  final jsondata =
      await rootBundle.rootBundle.loadString('assets/album_names.json');
  final album = json.decode(jsondata) as List<dynamic>;

  return album.map((json) => Album.fromJson(json)).toList();

  // return artists.map((e) => ArtistModel.fromJson(e)).toList();
}
