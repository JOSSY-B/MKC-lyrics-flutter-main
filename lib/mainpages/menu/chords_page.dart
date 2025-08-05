import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mkcchoirlyrics/boxes.dart';
import 'package:mkcchoirlyrics/constants/constants.dart';
import 'package:mkcchoirlyrics/database_hive/song_db.dart';
import 'package:mkcchoirlyrics/mainpages/menu/favorites_detail.dart';

class ChordsPage extends StatefulWidget {
  @override
  _ChordsPageState createState() => _ChordsPageState();
}

class _ChordsPageState extends State<ChordsPage> {
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
          style:
              TextStyle(fontSize: 24, color: Color.fromRGBO(235, 37, 35, 1.0)),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(
                thickness: 1.0,
                height: 1.0,
              ),
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
                              )),
                    );
                  },
                  child: Dismissible(
                    // Each Dismissible must contain a Key. Keys allow Flutter to
                    // uniquely identify widgets.
                    key: UniqueKey(),
                    // Provide a function that tells the app
                    // what to do after an item has been swiped away.
                    onDismissed: (direction) {
                      // Remove the item from the data source.
                      setState(() {
                        deleteTransaction(song);
                      });

                      // Then show a snackbar.
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(song.name + ' is deleted')));
                    },
                    // secondaryBackground: Container(
                    //   child: Center(
                    //     child: Text(
                    //       'Delete',
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //   ),
                    //   color: Colors.red,
                    // ),
                    // Show a red background as the item is swiped away.
                    background: Container(color: Colors.red),
                    direction: DismissDirection.endToStart,

                    child: ListTile(
                      title: Text(
                        song.name,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Row(
                            children: [
                              if (song.chord.isNotEmpty)
                                Expanded(
                                  child: Text(
                                    'Chord: ${song.chord}',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                              if (song.tempo.isNotEmpty) SizedBox(width: 4),
                              if (song.tempo.isNotEmpty)
                                Text(
                                  'Tempo: ${song.tempo}',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                            ],
                          ),
                          if (song.rhythm.isNotEmpty) SizedBox(height: 4),
                          if (song.rhythm.isNotEmpty)
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Rhythm: ${song.rhythm}',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                );

                // return buildTransaction(context, song);
              },
            ),
          ),
        ],
      );
    }
  }

  void deleteTransaction(SongsDb transaction) {
    transaction.delete();
  }
}
