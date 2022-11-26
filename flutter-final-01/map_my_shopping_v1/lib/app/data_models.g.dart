// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShopItemAdapter extends TypeAdapter<ShopItem> {
  @override
  final int typeId = 0;

  @override
  ShopItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShopItem(
      fields[0] as String,
      fields[1] as String,
      fields[2] as double,
      fields[3] as String,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ShopItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.product)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.aisle)
      ..writeByte(4)
      ..write(obj.department);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShopItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
