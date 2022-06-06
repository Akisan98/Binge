import 'package:hive/hive.dart';

part 'genres.g.dart';

@HiveType(typeId: 2)
class Genres {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  @override
  String toString() => name ?? '';
}
