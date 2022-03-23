// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pot_set.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PotSetAdapter extends TypeAdapter<PotSet> {
  @override
  final int typeId = 1;

  @override
  PotSet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PotSet(
      id: fields[0] as String,
      income: fields[1] as double,
      name: fields[2] as String,
      pots: (fields[3] as HiveList).castHiveList(),
    )
      ..unallocatedAmount = fields[4] as double
      ..unallocatedPercent = fields[5] as double;
  }

  @override
  void write(BinaryWriter writer, PotSet obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.income)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.pots)
      ..writeByte(4)
      ..write(obj.unallocatedAmount)
      ..writeByte(5)
      ..write(obj.unallocatedPercent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PotSetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
