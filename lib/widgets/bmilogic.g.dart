// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bmilogic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BMIRecordAdapter extends TypeAdapter<BMIRecord> {
  @override
  final int typeId = 0;

  @override
  BMIRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BMIRecord(
      height: fields[1] as double,
      weight: fields[2] as int,
      bmi: fields[3] as String,
      result: fields[4] as String,
      gender: fields[0] as String,
      age: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BMIRecord obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.gender)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.bmi)
      ..writeByte(4)
      ..write(obj.result)
      ..writeByte(5)
      ..write(obj.age);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BMIRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
