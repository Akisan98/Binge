// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_content.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MediaContentAdapter extends TypeAdapter<MediaContent> {
  @override
  final int typeId = 0;

  @override
  MediaContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MediaContent(
      tmdbId: fields[0] as int?,
      title: fields[1] as String?,
      runtime: fields[2] as int?,
      seasons: (fields[3] as List?)?.cast<DBSeasons>(),
      posterPath: fields[4] as String?,
      genres: (fields[5] as List?)?.cast<Genres>(),
      nextToAir: fields[6] as EpisodeToAir?,
      nextToWatch: fields[7] as EpisodeToAir?,
      type: fields[8] as MediaType?,
      nextRelease: fields[9] as String?,
      status: fields[10] as String?,
    )..notificationOnly = fields[11] as bool?;
  }

  @override
  void write(BinaryWriter writer, MediaContent obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.tmdbId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.runtime)
      ..writeByte(3)
      ..write(obj.seasons)
      ..writeByte(4)
      ..write(obj.posterPath)
      ..writeByte(5)
      ..write(obj.genres)
      ..writeByte(6)
      ..write(obj.nextToAir)
      ..writeByte(7)
      ..write(obj.nextToWatch)
      ..writeByte(8)
      ..write(obj.type)
      ..writeByte(9)
      ..write(obj.nextRelease)
      ..writeByte(10)
      ..write(obj.status)
      ..writeByte(11)
      ..write(obj.notificationOnly);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
