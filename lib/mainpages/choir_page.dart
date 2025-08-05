// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:mkcchoirlyrics/api/album_songs_api.dart';
// import 'package:mkcchoirlyrics/boxes.dart';
// import 'package:mkcchoirlyrics/constants/constants.dart';
// import 'dart:convert';
// import 'package:flutter/services.dart' as rootBundle;
// import 'package:mkcchoirlyrics/database_hive/song_db.dart';
//
// import 'package:mkcchoirlyrics/database_hive/track_db.dart';
// import 'package:mkcchoirlyrics/mainpages/song_detail.dart';
// import 'package:mkcchoirlyrics/model/track.dart';
//
// class ChoirPage extends StatefulWidget {
//   final String title;
//   final String jsonData;
//
//   const ChoirPage(
//       {super.key, required this.title, required this.jsonData});
//
//   @override
//   _ChoirPageState createState() => _ChoirPageState();
// }
//
// class _ChoirPageState extends State<ChoirPage> {
//   TextEditingController _textController = TextEditingController();
//
//   List<Track> _songs = [];
//   List<Track> _songsDisplay = [];
//   late final Box box;
//   Box songsBox = Hive.box<SongsDb>("song");
//   bool ascending = true;
//
//   @override
//   void initState() {
//     getSongs().then((value) {
//       setState(() {
//         _songs.addAll(value);
//         _songsDisplay = _songs;
//       });
//     });
//     super.initState();
//   }
//
//   // @override
//   // void initState() {
//   //   getDictinoary().then((value) {
//   //     if (this.mounted) {
//   //       setState(() {
//   //         _dictionary.addAll(value);
//   //         _dictionaryDisplay = _dictionary;
//   //       });
//   //     }
//   //   });
//   //   super.initState();
//   //   // _createInterstitialAd();
//   // }
//   Future<List<Track>> getSongs() async {
//     final jsondata = await rootBundle.rootBundle.loadString(widget.jsonData);
//     final song = json.decode(jsondata) as List<dynamic>;
//     return song.map((json) => Track.fromJson(json)).toList();
//
//     // return artists.map((e) => ArtistModel.fromJson(e)).toList();
//   }
//
//   // Future<List<Track>> getSongs() async {
//   //   final jsondata = await rootBundle.rootBundle.loadString(widget.jsonData);
//   //   final dict = json.decode(jsondata) as List<dynamic>;
//   //
//   //   return dict.map((json) => DictionaryDb.fromJson(json)).toList();
//   // }
//
//   void sortData() {
//     setState(() {
//       _songs.sort((a, b) {
//         if (ascending) {
//           return a.name.compareTo(b.name);
//         } else {
//           return b.name.compareTo(a.name);
//         }
//       });
//       ascending = !ascending;
//     });
//   }
//
//   void sortByYear() {
//     setState(() {
//       _songs.sort((a, b) {
//         if (ascending) {
//           return a.year.compareTo(b.year);
//         } else {
//           return b.year.compareTo(a.year);
//         }
//       });
//       ascending = !ascending;
//     });
//   }
//
//   onItemChanged(String value) {
//     setState(() {
//       _songsDisplay = _songs
//           .where((string) =>
//               string.name.toLowerCase().contains(value.toLowerCase()) ||
//               string.writer.toLowerCase().contains(value.toLowerCase()) ||
//               string.album.toLowerCase().contains(value.toLowerCase()) ||
//               string.detail.toLowerCase().contains(value.toLowerCase()))
//           .toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: mainBgColor,
//       appBar: AppBar(
//         backgroundColor: colorPrimary,
//         elevation: 0,
//         centerTitle: true,
//         leading: const BackButton(
//           color: Colors.white,
//         ),
//         title: Text(
//           widget.title,
//           style: TextStyle(color: Colors.white, fontFamily: 'Abyssinica'),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.sort_by_alpha,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               sortData();
//             },
//           ),
//           IconButton(
//             icon: Icon(
//               Icons.sort,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               sortByYear();
//             },
//           ),
//         ],
//       ),
//       body: ValueListenableBuilder<Box<SongsDb>>(
//         valueListenable: Boxes.getSongsDb().listenable(),
//         builder: (context, box, index) {
//           return Column(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: TextField(
//                   controller: _textController,
//                   decoration: const InputDecoration(
//                     contentPadding:
//                         EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide:
//                           BorderSide(color: Colors.blueGrey, width: 1.0),
//                       borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide:
//                           BorderSide(color: Colors.blueGrey, width: 2.0),
//                       borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                     ),
//                     hintText: 'Search song ...',
//                   ),
//                   onChanged: onItemChanged,
//                 ),
//               ),
//               Expanded(
//                 child: ListView.separated(
//                   padding: EdgeInsets.all(8),
//                   separatorBuilder: (BuildContext context, int index) =>
//                       Divider(
//                     height: 1.0,
//                   ),
//                   itemCount: _songsDisplay.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     final song = _songsDisplay[index];
//                     var filteredSongs = box.values
//                         .where((songn) => songn.id == song.id)
//                         .toList();
//                     bool isSaved = filteredSongs.isNotEmpty;
//
//                     return ListTile(
//                         title: Text(song.name,
//                             style: TextStyle(
//                                 fontSize: 22, fontFamily: 'Abyssinica')),
//                         subtitle: Text(
//                             "ከ${song.album} አልበም",
//                             style: TextStyle(
//                                 fontSize: 20, color: Colors.black54, fontFamily: 'Abyssinica')),
//                         trailing: IconButton(
//                           icon: Icon(
//                             isSaved ? Icons.favorite : Icons.favorite_border,
//                             color: isSaved ? Colors.red : null,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               if (isSaved) {
//                                 print("favo deleted is " + song.name);
//                                 deleteItem(song.id);
//                               } else {
//                                 addSongsToDb(
//                                   song.id,
//                                   song.name,
//                                   song.detail,
//                                   song.year,
//                                   song.chord,
//                                   song.rhythm,
//                                   song.tempo,
//                                   song.album_id,
//                                 );
//                                 // Toast.show(song.name + " is Added to Favorites!",
//                                 //     context,
//                                 //     duration: Toast.LENGTH_SHORT,
//                                 //     gravity: Toast.TOP);
//                                 print("favo added is " + song.name);
//                               }
//                             });
//                           },
//                         ),
//                         onTap: () {
//                           // var rng = new Random();
//                           // var numb = rng.nextInt(100);
//                           // if (numb >= 70) {
//                           //   print("ad shown");
//                           //   print(numb);
//                           //   _showInterstitialAd();
//                           // } else {
//                           //   print("ad not shown");
//                           // }
//
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => SongPage(song: song)));
//                         });
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//
//   Future addSongsToDb(
//       int id,
//       String name,
//       String detail,
//       String year,
//       String chord,
//       String rhythm,
//       String tempo,
//       String album_id,
//       ) async {
//     final song = SongsDb()
//       ..id = id
//       ..name = name
//       ..detail = detail
//       ..year = year
//       ..chord = chord
//       ..rhythm = rhythm
//       ..tempo = tempo
//       ..album_id = album_id;
//
//     final box = Boxes.getSongsDb();
//     box.add(song);
//     //box.put('mykey', transaction);
//
//     // final mybox = Boxes.getTransactions();
//     // final myTransaction = mybox.get('key');
//     // mybox.values;
//     // mybox.keys;
//   }
//
//   void editSongsOnDb(
//       SongsDb songsDb,
//       int id,
//       String name,
//       String detail,
//       String year,
//       String chord,
//       String rhythm,
//       String tempo,
//       String album_id,
//       ) {
//     songsDb.id = id;
//     songsDb.name = name;
//     songsDb.detail = detail;
//     songsDb.year = year;
//     songsDb.chord = chord;
//     songsDb.rhythm = rhythm;
//     songsDb.tempo = tempo;
//     songsDb.album_id = album_id;
//
//     // final box = Boxes.getTransactions();
//     // box.put(transaction.key, transaction);
//
//     songsDb.save();
//   }
//
//   void deleteSong(SongsDb songsDb) {
//     // final box = Boxes.getSongsDb();
//     // box.delete(songsDb.key);
//
//     songsDb.delete();
//     //setState(() => transactions.remove(transaction));
//   }
//
//   deleteItem(int id) {
//     final box = Hive.box<SongsDb>("song");
//
//     final Map<dynamic, SongsDb> deliveriesMap = box.toMap();
//     dynamic desiredKey;
//     deliveriesMap.forEach((key, value) {
//       if (value.id == id) desiredKey = key;
//     });
//     box.delete(desiredKey);
//   }
// }
