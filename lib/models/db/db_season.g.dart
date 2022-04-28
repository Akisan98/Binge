// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_season.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DBSeasonsAdapter extends TypeAdapter<DBSeasons> {
  @override
  final int typeId = 1;

  @override
  DBSeasons read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DBSeasons(
      episodesSeen: fields[0] as int?,
      episodes: fields[1] as int?,
      seasonNumber: fields[2] as int?,
      name: fields[3] as String?,
      episodesSeenArray: (fields[4] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, DBSeasons obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.episodesSeen)
      ..writeByte(1)
      ..write(obj.episodes)
      ..writeByte(2)
      ..write(obj.seasonNumber)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.episodesSeenArray);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DBSeasonsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
