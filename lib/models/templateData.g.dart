// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'templateData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TemplateDataTypeAdapter extends TypeAdapter<TemplateDataType> {
  @override
  final int typeId = 1;

  @override
  TemplateDataType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TemplateDataType.BubbleTab;
      case 1:
        return TemplateDataType.Counter;
      case 2:
        return TemplateDataType.TextInput;
      case 3:
        return TemplateDataType.NumberInput;
      case 4:
        return TemplateDataType.Timer;
      case 5:
        return TemplateDataType.Header;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, TemplateDataType obj) {
    switch (obj) {
      case TemplateDataType.BubbleTab:
        writer.writeByte(0);
        break;
      case TemplateDataType.Counter:
        writer.writeByte(1);
        break;
      case TemplateDataType.TextInput:
        writer.writeByte(2);
        break;
      case TemplateDataType.NumberInput:
        writer.writeByte(3);
        break;
      case TemplateDataType.Timer:
        writer.writeByte(4);
        break;
      case TemplateDataType.Header:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TemplateDataTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TemplateAdapter extends TypeAdapter<Template> {
  @override
  final int typeId = 0;

  @override
  Template read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Template(
      name: fields[0] as String,
      data: (fields[1] as List)?.cast<TemplateData>(),
    );
  }

  @override
  void write(BinaryWriter writer, Template obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TemplateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TemplateDataAdapter extends TypeAdapter<TemplateData> {
  @override
  final int typeId = 2;

  @override
  TemplateData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TemplateData(
      title: fields[0] as String,
      dbName: fields[1] as String,
      type: fields[2] as TemplateDataType,
      display: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TemplateData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.dbName)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.display);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TemplateDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
