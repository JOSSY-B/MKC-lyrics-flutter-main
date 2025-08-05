import 'package:hive/hive.dart';

part 'song_db.g.dart';

@HiveType(typeId: 0)
class SongsDb extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String detail;

  @HiveField(3)
  late String year;

  @HiveField(4)
  late String chord;

  @HiveField(5)
  late String rhythm;

  @HiveField(6)
  late String tempo;

  @HiveField(7)
  late String album_id;
}

