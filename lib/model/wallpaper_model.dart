import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'wallpaper_model.g.dart';

@HiveType(typeId: 2)
class WallpaperModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? width;
  @HiveField(2)
  int? height;
  @HiveField(3)
  String? url;
  @HiveField(4)
  String? photographer;
  @HiveField(5)
  String? photographerUrl;
  @HiveField(6)
  int? photographerId;
  @HiveField(7)
  String? avgColor;
  @HiveField(8)
  Src? src;
  @HiveField(9)
  bool? liked;
  @HiveField(10)
  String? alt;

  WallpaperModel(
      {this.id,
      this.width,
      this.height,
      this.url,
      this.photographer,
      this.photographerUrl,
      this.photographerId,
      this.avgColor,
      this.src,
      this.liked,
      this.alt});

  WallpaperModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    photographer = json['photographer'];
    photographerUrl = json['photographer_url'];
    photographerId = json['photographer_id'];
    avgColor = json['avg_color'];
    src = json['src'] != null ? Src.fromJson(json['src']) : null;
    liked = json['liked'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['width'] = width;
    data['height'] = height;
    data['url'] = url;
    data['photographer'] = photographer;
    data['photographer_url'] = photographerUrl;
    data['photographer_id'] = photographerId;
    data['avg_color'] = avgColor;
    if (src != null) {
      data['src'] = src!.toJson();
    }
    data['liked'] = liked;
    data['alt'] = alt;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        width,
        height,
        url,
        photographer,
        photographerUrl,
        photographerId,
        avgColor,
        src,
        liked,
        alt,
      ];
}

@HiveType(typeId: 3)
class Src extends HiveObject with EquatableMixin {
  @HiveField(0)
  String? original;
  @HiveField(1)
  String? large2x;
  @HiveField(2)
  String? large;
  @HiveField(3)
  String? medium;
  @HiveField(4)
  String? small;
  @HiveField(5)
  String? portrait;
  @HiveField(6)
  String? landscape;
  @HiveField(7)
  String? tiny;

  Src(
      {this.original,
      this.large2x,
      this.large,
      this.medium,
      this.small,
      this.portrait,
      this.landscape,
      this.tiny});

  Src.fromJson(Map<String, dynamic> json) {
    original = json['original'];
    large2x = json['large2x'];
    large = json['large'];
    medium = json['medium'];
    small = json['small'];
    portrait = json['portrait'];
    landscape = json['landscape'];
    tiny = json['tiny'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['original'] = original;
    data['large2x'] = large2x;
    data['large'] = large;
    data['medium'] = medium;
    data['small'] = small;
    data['portrait'] = portrait;
    data['landscape'] = landscape;
    data['tiny'] = tiny;
    return data;
  }

  @override
  List<Object?> get props => [
        original,
        large2x,
        large,
        medium,
        small,
        portrait,
        landscape,
        tiny,
      ];
}
