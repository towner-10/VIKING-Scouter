// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teamData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeamDataAdapter extends TypeAdapter<TeamData> {
  @override
  final int typeId = 3;

  @override
  TeamData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeamData(
      teamNumber: fields[0] as int,
      teamName: fields[1] as String,
      scoutData: (fields[2] as Map)?.cast<String, dynamic>(),
      headerImage: fields[3] as String,
      images: (fields[4] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TeamData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.teamNumber)
      ..writeByte(1)
      ..write(obj.teamName)
      ..writeByte(2)
      ..write(obj.scoutData)
      ..writeByte(3)
      ..write(obj.headerImage)
      ..writeByte(4)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
