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
  _ChordsPageState createState() => _ChordsPageState();
}

class _ChordsPageState extends State<FavoriteSongs> {
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
          'No Favorites Added!',
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
                    background: Container(
                      color: Colors.red,
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    direction: DismissDirection.endToStart,

                    child: ListTile(
                      title: Text(
                        song.name,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.normal),
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
