// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_to_air.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EpisodeToAirAdapter extends TypeAdapter<EpisodeToAir> {
  @override
  final int typeId = 3;

  @override
  EpisodeToAir read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EpisodeToAir(
      airDate: fields[0] as String?,
      episodeNumber: fields[1] as int?,
      id: fields[2] as int?,
      name: fields[3] as String?,
      overview: fields[4] as String?,
      productionCode: fields[5] as String?,
      seasonNumber: fields[6] as int?,
      stillPath: fields[7] as String?,
      voteAverage: fields[8] as double?,
      voteCount: fields[9] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, EpisodeToAir obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.airDate)
      ..writeByte(1)
      ..write(obj.episodeNumber)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.overview)
      ..writeByte(5)
      ..write(obj.productionCode)
      ..writeByte(6)
      ..write(obj.seasonNumber)
      ..writeByte(7)
      ..write(obj.stillPath)
      ..writeByte(8)
      ..write(obj.voteAverage)
      ..writeByte(9)
      ..write(obj.voteCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EpisodeToAirAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
