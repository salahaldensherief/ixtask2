// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pizza_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PizzaItemModelAdapter extends TypeAdapter<PizzaItemModel> {
  @override
  final int typeId = 0;

  @override
  PizzaItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PizzaItemModel(
      id: fields[0] as String?,
      name: fields[1] as String,
      description: fields[2] as String,
      basePrice: fields[3] as double,
      icon: fields[4] as String?,
      options: (fields[5] as List).cast<PizzaItemModel>(),
      selectOptions: (fields[6] as List).cast<PizzaItemModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, PizzaItemModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.basePrice)
      ..writeByte(4)
      ..write(obj.icon)
      ..writeByte(5)
      ..write(obj.options)
      ..writeByte(6)
      ..write(obj.selectOptions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PizzaItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
