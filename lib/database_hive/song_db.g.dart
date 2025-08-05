// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongsDbAdapter extends TypeAdapter<SongsDb> {
  @override
  final int typeId = 0;

  @override
  SongsDb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongsDb()
      ..id = fields[0] as int
      ..name = fields[1] as String
      ..detail = fields[2] as String
      ..year = fields[3] as String
      ..chord = fields[4] as String
      ..rhythm = fields[5] as String
      ..tempo = fields[6] as String
      ..album_id = fields[7] as String;
  }

  @override
  void write(BinaryWriter writer, SongsDb obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.detail)
      ..writeByte(3)
      ..write(obj.year)
      ..writeByte(4)
      ..write(obj.chord)
      ..writeByte(5)
      ..write(obj.rhythm)
      ..writeByte(6)
      ..write(obj.tempo)
      ..writeByte(7)
      ..write(obj.album_id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongsDbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
