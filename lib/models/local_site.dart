import 'package:hive/hive.dart';
part 'local_site.g.dart';

@HiveType(typeId: 0)
class LocalSite extends HiveObject{

  @HiveField(0)
  String? id;

  @HiveField(1)
  String? nameSite;

  @HiveField(2)
  String? generalDescription;

  @HiveField(3)
  String? photo;

  @HiveField(4)
  double? rating;

  @HiveField(5)
  String? town;

  @HiveField(6)
  String? department;

  @HiveField(7)
  String? detailedDescription;

  @HiveField(8)
  String? moreInformation;

  @HiveField(9)
  double? latitude;

  @HiveField(10)
  double? longitude;
}