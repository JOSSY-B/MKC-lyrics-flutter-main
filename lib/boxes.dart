import 'package:hive/hive.dart';
import 'package:mkcchoirlyrics/database_hive/song_db.dart';

class Boxes {
  static Box<SongsDb> getSongsDb() => Hive.box<SongsDb>('song');
}
