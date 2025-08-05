import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mkcchoirlyrics/boxes.dart';
import 'package:mkcchoirlyrics/constants/constants.dart';
import 'package:mkcchoirlyrics/database_hive/song_db.dart';
import 'package:mkcchoirlyrics/mainpages/menu/favorites_detail.dart';

class FavoriteSongs extends StatefulWidget {
  @override
  _FavoriteSongsState createState() => _FavoriteSongsState();
}

class _FavoriteSongsState extends State<FavoriteSongs> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: mainBgColor,
        body: ValueListenableBuilder<Box<SongsDb>>(
          valueListenable: Boxes.getSongsDb().listenable(),
          builder: (context, box, _) {
            final songs = box.values.toList().cast<SongsDb>();

            return buildContent(songs);
          },
        ),
      );

  Widget buildContent(List<SongsDb> songs) {
    if (songs.isEmpty) {
      return Center(
        child: Text(
          'No Chords Added!',
          style: TextStyle(
            fontSize: 24,
            color: Color.fromRGBO(235, 37, 35, 1.0),
          ),
        ),
      );
    } else {
      return ReorderableListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: songs.length,
        itemBuilder: (BuildContext context, int index) {
          final song = songs[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailFavorites(
                    songDetail: song.detail,
                    songName: song.name,
                    rhythm: song.rhythm,
                    chord: song.chord,
                    tempo: song.tempo,
                  ),
                ),
              );
            },
            child: Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {
                  deleteTransaction(song);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(song.name + ' is deleted')),
                );
              },
              background: Container(color: Colors.red),
              direction: DismissDirection.endToStart,
              child: ListTile(
                key: ValueKey(song.id), // Use song.id as the key
                title: Text(
                  song.name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Chord: ${song.chord}',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Tempo: ${song.tempo}',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Rhythm: ${song.rhythm}',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final song = songs.removeAt(oldIndex);
            songs.insert(newIndex, song);
          });
        },
      );
    }
  }

  void deleteTransaction(SongsDb transaction) {
    transaction.delete();
  }
}
