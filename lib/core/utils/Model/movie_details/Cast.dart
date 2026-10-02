/// name : "Eriq Ebouaney"
/// character_name : "Garba"
/// url_small_image : "https://yts.gg/assets/images/actors/thumb/nm0248254.jpg"
/// imdb_code : "0248254"

class Cast {
  Cast({
      this.name, 
      this.characterName, 
      this.urlSmallImage, 
      this.imdbCode,});

  Cast.fromJson(dynamic json) {
    name = json['name'];
    characterName = json['character_name'];
    urlSmallImage = json['url_small_image'];
    imdbCode = json['imdb_code'];
  }
  String? name;
  String? characterName;
  String? urlSmallImage;
  String? imdbCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['character_name'] = characterName;
    map['url_small_image'] = urlSmallImage;
    map['imdb_code'] = imdbCode;
    return map;
  }

}