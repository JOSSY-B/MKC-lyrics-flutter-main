import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mkcchoirlyrics/api/all_songs_api.dart';
import 'package:mkcchoirlyrics/api/album_songs_api.dart';
import 'package:mkcchoirlyrics/boxes.dart';
import 'package:mkcchoirlyrics/constants/constants.dart';
import 'package:mkcchoirlyrics/database_hive/song_db.dart';
import 'package:mkcchoirlyrics/database_hive/track_db.dart';
import 'package:mkcchoirlyrics/mainpages/song_detail.dart';
import 'dart:io';

import 'package:mkcchoirlyrics/model/album.dart';
import 'package:mkcchoirlyrics/model/all_songs.dart';
import 'package:mkcchoirlyrics/model/track.dart';

class SongsList extends StatefulWidget {
  final Album album;

  SongsList({Key? key, required this.album}) : super(key: key);

  @override
  _SongsListState createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  List<AllSongsModel> _songs = [];
  List<AllSongsModel> _songsDisplay = [];
  late final Box box;

  Box songsBox = Hive.box<SongsDb>("song");

  @override
  void initState() {
    getAllSongs().then((value) {
      setState(() {
        _songs.addAll(value);
        _songsDisplay = _songs
            .where((val) => val.album_id == widget.album.album_id)
            .toList();
      });
    });
    super.initState();
    // _createInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();
    // _interstitialAd?.dispose();
    // bAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBgColor,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        elevation: 0,
        centerTitle: true,
        leading: BackButton(color: Colors.white),
        title: Text(
          widget.album.album,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ValueListenableBuilder<Box<SongsDb>>(
        valueListenable: Boxes.getSongsDb().listenable(),
        builder: (context, box, index) {
          final songsDbs = box.values.toList().cast<SongsDb>();

          return Column(
            children: [
              const SizedBox(height: 5),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(
                      left: 8.0, top: 2.0, right: 8.0, bottom: 2.0),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(height: 1, color: Colors.grey),
                  itemCount: _songsDisplay.length,
                  itemBuilder: (BuildContext context, int index) {
                    final song = _songsDisplay[index];
                    // final songOne = songsDbs[index];
                    // bool isSaved = songsBox.containsKey(song.id);
                    var favoritedSongs = box.values
                        .where((songn) => songn.id == song.id)
                        .toList();
                    bool isSaved = favoritedSongs.isNotEmpty;
                    // bool isSaved = box.containsKey(song.id);
                    // print(songsDbs);

                    return ListTile(
                        title: Text(song.name,
                            style: TextStyle(
                                fontSize: 22, fontFamily: 'Abyssinica')),
                        subtitle: Text(widget.album.album,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontFamily: 'Abyssinica')),
                        trailing: IconButton(
                          icon: Icon(
                            isSaved ? Icons.favorite : Icons.favorite_border,
                            color: isSaved ? Colors.red : null,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isSaved) {
                                // savedWords.remove(word);
                                print("favo deleted is " + song.name);
                                deleteItem(song.id);
                              } else {
                                // savedWords.add(word);
                                addSongsToDb(
                                  song.id,
                                  song.name,
                                  song.detail,
                                  song.year,
                                  song.chord,
                                  song.rhythm,
                                  song.tempo,
                                  song.album_id,
                                );
                                print("favo added is " + song.name);
                              }
                            });
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SongDetail(song: song),
                            ),
                          );
                        });
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          );
        },
      ),
    );
  }

  Future addSongsToDb(
    int id,
    String name,
    String detail,
    String year,
    String chord,
    String rhythm,
    String tempo,
    String album_id,
  ) async {
    final song = SongsDb()
      ..id = id
      ..name = name
      ..detail = detail
      ..year = year
      ..chord = chord
      ..rhythm = rhythm
      ..tempo = tempo
      ..album_id = album_id;

    final box = Boxes.getSongsDb();
    box.add(song);
    //box.put('mykey', transaction);

    // final mybox = Boxes.getTransactions();
    // final myTransaction = mybox.get('key');
    // mybox.values;
    // mybox.keys;
  }

  void editSongsOnDb(
    SongsDb songsDb,
    int id,
    String name,
    String detail,
    String year,
    String chord,
    String rhythm,
    String tempo,
    String album_id,
  ) {
    songsDb.id = id;
    songsDb.name = name;
    songsDb.detail = detail;
    songsDb.year = year;
    songsDb.chord = chord;
    songsDb.rhythm = rhythm;
    songsDb.tempo = tempo;
    songsDb.album_id = album_id;

    // final box = Boxes.getTransactions();
    // box.put(transaction.key, transaction);

    songsDb.save();
  }

  void deleteSong(SongsDb songsDb) {
    // final box = Boxes.getSongsDb();
    // box.delete(songsDb.key);

    songsDb.delete();
    //setState(() => transactions.remove(transaction));
  }

  deleteItem(int id) {
    final box = Hive.box<SongsDb>("song");

    final Map<dynamic, SongsDb> deliveriesMap = box.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.id == id) desiredKey = key;
    });
    box.delete(desiredKey);
  }
}
