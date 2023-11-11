import 'package:hive/hive.dart';

import 'wallpaper_model.dart';

part 'favorite_model.g.dart';

@HiveType(typeId: 1)
class FavoriteModel extends HiveObject {
  @HiveField(0)
  String email;
  @HiveField(1)
  List<WallpaperModel> favorites;

  FavoriteModel({
    required this.email,
    required this.favorites,
  });
}
