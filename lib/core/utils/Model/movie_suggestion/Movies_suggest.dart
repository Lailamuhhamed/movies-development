import 'Torrents.dart';

/// id : 6162
/// url : "https://yts.gg/movies/hands-of-stone-2016"
/// imdb_code : "tt1781827"
/// title : "Hands of Stone"
/// title_english : "Hands of Stone"
/// title_long : "Hands of Stone (2016)"
/// slug : "hands-of-stone-2016"
/// year : 2016
/// rating : 6.6
/// runtime : 111
/// genres : ["Action","Biography","Drama","Sport"]
/// summary : "The legendary Roberto Duran and his equally legendary trainer Ray Arcel change each other's lives."
/// description_full : "The legendary Roberto Duran and his equally legendary trainer Ray Arcel change each other's lives."
/// synopsis : "The legendary Roberto Duran and his equally legendary trainer Ray Arcel change each other's lives."
/// yt_trailer_code : "KeP5YVVkQV8"
/// language : "en"
/// mpa_rating : "R"
/// background_image : "https://yts.gg/assets/images/movies/hands_of_stone_2016/background.jpg"
/// background_image_original : "https://yts.gg/assets/images/movies/hands_of_stone_2016/background.jpg"
/// small_cover_image : "https://yts.gg/assets/images/movies/hands_of_stone_2016/small-cover.jpg"
/// medium_cover_image : "https://yts.gg/assets/images/movies/hands_of_stone_2016/medium-cover.jpg"
/// state : "ok"
/// torrents : [{"url":"https://yts.gg/torrent/download/34362C07B42D2FC56070D43D80CAF7B9C3FAB5C6","hash":"34362C07B42D2FC56070D43D80CAF7B9C3FAB5C6","quality":"720p","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":5,"peers":0,"size":"823.03 MB","size_bytes":863009505,"date_uploaded":"2016-11-02 13:14:14","date_uploaded_unix":1478088854},{"url":"https://yts.gg/torrent/download/976422B0CDB8D27E0701B3AA6D832AF235E6A8C4","hash":"976422B0CDB8D27E0701B3AA6D832AF235E6A8C4","quality":"1080p","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":15,"peers":6,"size":"1.7 GB","size_bytes":1825361101,"date_uploaded":"2016-11-02 16:38:32","date_uploaded_unix":1478101112}]
/// date_uploaded : "2016-11-02 13:14:14"
/// date_uploaded_unix : 1478088854

class MoviesSuggest {
  MoviesSuggest({
      this.id, 
      this.url, 
      this.imdbCode, 
      this.title, 
      this.titleEnglish, 
      this.titleLong, 
      this.slug, 
      this.year, 
      this.rating, 
      this.runtime, 
      this.genres, 
      this.summary, 
      this.descriptionFull, 
      this.synopsis, 
      this.ytTrailerCode, 
      this.language, 
      this.mpaRating, 
      this.backgroundImage, 
      this.backgroundImageOriginal, 
      this.smallCoverImage, 
      this.mediumCoverImage, 
      this.state, 
      this.torrents, 
      this.dateUploaded, 
      this.dateUploadedUnix,});

  MoviesSuggest.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    imdbCode = json['imdb_code'];
    title = json['title'];
    titleEnglish = json['title_english'];
    titleLong = json['title_long'];
    slug = json['slug'];
    year = json['year'];
    rating = json['rating'];
    runtime = json['runtime'];
    genres = json['genres'] != null ? json['genres'].cast<String>() : [];
    summary = json['summary'];
    descriptionFull = json['description_full'];
    synopsis = json['synopsis'];
    ytTrailerCode = json['yt_trailer_code'];
    language = json['language'];
    mpaRating = json['mpa_rating'];
    backgroundImage = json['background_image'];
    backgroundImageOriginal = json['background_image_original'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    state = json['state'];
    if (json['torrents'] != null) {
      torrents = [];
      json['torrents'].forEach((v) {
        torrents?.add(Torrents.fromJson(v));
      });
    }
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }
  int? id;
  String? url;
  String? imdbCode;
  String? title;
  String? titleEnglish;
  String? titleLong;
  String? slug;
  int? year;
  double? rating;
  int? runtime;
  List<String>? genres;
  String? summary;
  String? descriptionFull;
  String? synopsis;
  String? ytTrailerCode;
  String? language;
  String? mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? state;
  List<Torrents>? torrents;
  String? dateUploaded;
  int? dateUploadedUnix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['imdb_code'] = imdbCode;
    map['title'] = title;
    map['title_english'] = titleEnglish;
    map['title_long'] = titleLong;
    map['slug'] = slug;
    map['year'] = year;
    map['rating'] = rating;
    map['runtime'] = runtime;
    map['genres'] = genres;
    map['summary'] = summary;
    map['description_full'] = descriptionFull;
    map['synopsis'] = synopsis;
    map['yt_trailer_code'] = ytTrailerCode;
    map['language'] = language;
    map['mpa_rating'] = mpaRating;
    map['background_image'] = backgroundImage;
    map['background_image_original'] = backgroundImageOriginal;
    map['small_cover_image'] = smallCoverImage;
    map['medium_cover_image'] = mediumCoverImage;
    map['state'] = state;
    if (torrents != null) {
      map['torrents'] = torrents?.map((v) => v.toJson()).toList();
    }
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }

}