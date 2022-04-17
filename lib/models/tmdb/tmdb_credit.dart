class TMDBCredit {
  int? id;
  List<Cast>? cast;

  TMDBCredit({this.id, this.cast});

  TMDBCredit.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    cast = <Cast>[];

    if (json['cast'] != null) {
      json['cast'].forEach((v) {
        cast!.add(Cast.fromJson(v));
      });
    }
    // if (json['crew'] != null) {
    //   json['crew'].forEach((v) {
    //     cast!.add(Cast.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (cast != null) {
      data['cast'] = cast!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cast {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;
  String? mediaType;

  Cast(
      {this.adult,
      this.gender,
      this.id,
      this.knownForDepartment,
      this.name,
      this.originalName,
      this.popularity,
      this.profilePath,
      this.castId,
      this.character,
      this.creditId,
      this.order,
      this.mediaType});

  Cast.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'] ?? json['title'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'] ?? json['poster_path'];
    castId = json['cast_id'];
    character = json['character'] ?? json['job'];
    creditId = json['credit_id'];
    order = json['order'];
    mediaType = json['media_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['gender'] = gender;
    data['id'] = id;
    data['known_for_department'] = knownForDepartment;
    data['name'] = name;
    data['original_name'] = originalName;
    data['popularity'] = popularity;
    data['profile_path'] = profilePath;
    data['cast_id'] = castId;
    data['character'] = character;
    data['credit_id'] = creditId;
    data['order'] = order;
    return data;
  }
}
