

import 'package:hive/hive.dart';
import 'package:mi_musica/models/local_site.dart';

class Boxes {
  static Box<LocalSite> getFavoritesBox() => Hive.box<LocalSite>('favorites');
}