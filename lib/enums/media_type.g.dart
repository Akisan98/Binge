// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MediaTypeAdapter extends TypeAdapter<MediaType> {
  @override
  final int typeId = 4;

  @override
  MediaType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MediaType.person;
      case 1:
        return MediaType.movie;
      case 2:
        return MediaType.tvSeries;
      default:
        return MediaType.person;
    }
  }

  @override
  void write(BinaryWriter writer, MediaType obj) {
    switch (obj) {
      case MediaType.person:
        writer.writeByte(0);
        break;
      case MediaType.movie:
        writer.writeByte(1);
        break;
      case MediaType.tvSeries:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
