// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_site.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalSiteAdapter extends TypeAdapter<LocalSite> {
  @override
  final int typeId = 0;

  @override
  LocalSite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalSite()
      ..id = fields[0] as String?
      ..nameSite = fields[1] as String?
      ..generalDescription = fields[2] as String?
      ..photo = fields[3] as String?
      ..rating = fields[4] as double?
      ..town = fields[5] as String?
      ..department = fields[6] as String?
      ..detailedDescription = fields[7] as String?
      ..moreInformation = fields[8] as String?
      ..latitude = fields[9] as double?
      ..longitude = fields[10] as double?;
  }

  @override
  void write(BinaryWriter writer, LocalSite obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nameSite)
      ..writeByte(2)
      ..write(obj.generalDescription)
      ..writeByte(3)
      ..write(obj.photo)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.town)
      ..writeByte(6)
      ..write(obj.department)
      ..writeByte(7)
      ..write(obj.detailedDescription)
      ..writeByte(8)
      ..write(obj.moreInformation)
      ..writeByte(9)
      ..write(obj.latitude)
      ..writeByte(10)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LocalSiteAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}