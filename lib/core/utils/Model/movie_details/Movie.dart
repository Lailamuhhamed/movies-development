import 'Cast.dart';
import 'Torrents.dart';

/// id : 78137
/// url : "https://yts.gg/movies/soumsoum-la-nuit-des-astres-2026"
/// imdb_code : "tt39075020"
/// title : "Soumsoum, la nuit des astres"
/// title_english : "Soumsoum, la nuit des astres"
/// title_long : "Soumsoum, la nuit des astres (2026)"
/// slug : "soumsoum-la-nuit-des-astres-2026"
/// year : 2026
/// rating : 6.3
/// runtime : 101
/// genres : ["Action","Adventure","Drama","Fantasy","Romance","Sci-Fi"]
/// like_count : 3
/// description_intro : "A 17-year-old named Kellou discovers unexplained supernatural powers. Meeting Aya transforms her confusion into a mystical journey where visible and invisible realms meet."
/// description_full : "A 17-year-old named Kellou discovers unexplained supernatural powers. Meeting Aya transforms her confusion into a mystical journey where visible and invisible realms meet."
/// yt_trailer_code : "hzb6nXtUcI4"
/// language : "fr"
/// mpa_rating : ""
/// background_image : "https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/background.jpg"
/// background_image_original : "https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/background.jpg"
/// small_cover_image : "https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/small-cover.jpg"
/// medium_cover_image : "https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/medium-cover.jpg"
/// large_cover_image : "https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/large-cover.jpg"
/// medium_screenshot_image1 : "https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/medium-screenshot1.jpg"
/// medium_screenshot_image2 : "https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/medium-screenshot2.jpg"
/// medium_screenshot_image3 : "https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/medium-screenshot3.jpg"
/// large_screenshot_image1 : "https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/large-screenshot1.jpg"
/// large_screenshot_image2 : "https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/large-screenshot2.jpg"
/// large_screenshot_image3 : "https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/large-screenshot3.jpg"
/// cast : [{"name":"Eriq Ebouaney","character_name":"Garba","url_small_image":"https://yts.gg/assets/images/actors/thumb/nm0248254.jpg","imdb_code":"0248254"},{"name":"Achouackh Abakar Souleymane","character_name":"Aya","imdb_code":"6178643"},{"name":"Maïmouna Miawama","character_name":"Kellou","imdb_code":"17935224"},{"name":"Brigitte Tchanegue","character_name":"Aïcha","imdb_code":"17144014"}]
/// torrents : [{"url":"https://yts.gg/torrent/download/99A655F052C1D17DA043C0D96EA034C5158A2E6B","hash":"99A655F052C1D17DA043C0D96EA034C5158A2E6B","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"931.47 MB","size_bytes":976717087,"date_uploaded":"2026-08-26 12:01:50","date_uploaded_unix":1787738510},{"url":"https://yts.gg/torrent/download/89A8455A370EC25451F3B1C764ED82CB21DDFC1D","hash":"89A8455A370EC25451F3B1C764ED82CB21DDFC1D","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"5.1","seeds":0,"peers":0,"size":"1.87 GB","size_bytes":2007897211,"date_uploaded":"2026-08-26 12:58:25","date_uploaded_unix":1787741905}]
/// date_uploaded : "2026-08-26 12:01:50"
/// date_uploaded_unix : 1787738510

class Movie {
  Movie({
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
      this.likeCount, 
      this.descriptionIntro, 
      this.descriptionFull, 
      this.ytTrailerCode, 
      this.language, 
      this.mpaRating, 
      this.backgroundImage, 
      this.backgroundImageOriginal, 
      this.smallCoverImage, 
      this.mediumCoverImage, 
      this.largeCoverImage, 
      this.mediumScreenshotImage1, 
      this.mediumScreenshotImage2, 
      this.mediumScreenshotImage3, 
      this.largeScreenshotImage1, 
      this.largeScreenshotImage2, 
      this.largeScreenshotImage3, 
      this.cast, 
      this.torrents, 
      this.dateUploaded, 
      this.dateUploadedUnix,});

  Movie.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    imdbCode = json['imdb_code'];
    title = json['title'];
    titleEnglish = json['title_english'];
    titleLong = json['title_long'];
    slug = json['slug'];
    year = json['year'];
    rating =  json['rating'] != null ? (json['rating'] as num).toDouble() : null;
    runtime = json['runtime'];
    genres = json['genres'] != null ? json['genres'].cast<String>() : [];
    likeCount = json['like_count'];
    descriptionIntro = json['description_intro'];
    descriptionFull = json['description_full'];
    ytTrailerCode = json['yt_trailer_code'];
    language = json['language'];
    mpaRating = json['mpa_rating'];
    backgroundImage = json['background_image'];
    backgroundImageOriginal = json['background_image_original'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    largeCoverImage = json['large_cover_image'];
    mediumScreenshotImage1 = json['medium_screenshot_image1'];
    mediumScreenshotImage2 = json['medium_screenshot_image2'];
    mediumScreenshotImage3 = json['medium_screenshot_image3'];
    largeScreenshotImage1 = json['large_screenshot_image1'];
    largeScreenshotImage2 = json['large_screenshot_image2'];
    largeScreenshotImage3 = json['large_screenshot_image3'];
    if (json['cast'] != null) {
      cast = [];
      json['cast'].forEach((v) {
        cast?.add(Cast.fromJson(v));
      });
    }
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
  int? likeCount;
  String? descriptionIntro;
  String? descriptionFull;
  String? ytTrailerCode;
  String? language;
  String? mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? largeCoverImage;
  String? mediumScreenshotImage1;
  String? mediumScreenshotImage2;
  String? mediumScreenshotImage3;
  String? largeScreenshotImage1;
  String? largeScreenshotImage2;
  String? largeScreenshotImage3;
  List<Cast>? cast;
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
    map['like_count'] = likeCount;
    map['description_intro'] = descriptionIntro;
    map['description_full'] = descriptionFull;
    map['yt_trailer_code'] = ytTrailerCode;
    map['language'] = language;
    map['mpa_rating'] = mpaRating;
    map['background_image'] = backgroundImage;
    map['background_image_original'] = backgroundImageOriginal;
    map['small_cover_image'] = smallCoverImage;
    map['medium_cover_image'] = mediumCoverImage;
    map['large_cover_image'] = largeCoverImage;
    map['medium_screenshot_image1'] = mediumScreenshotImage1;
    map['medium_screenshot_image2'] = mediumScreenshotImage2;
    map['medium_screenshot_image3'] = mediumScreenshotImage3;
    map['large_screenshot_image1'] = largeScreenshotImage1;
    map['large_screenshot_image2'] = largeScreenshotImage2;
    map['large_screenshot_image3'] = largeScreenshotImage3;
    if (cast != null) {
      map['cast'] = cast?.map((v) => v.toJson()).toList();
    }
    if (torrents != null) {
      map['torrents'] = torrents?.map((v) => v.toJson()).toList();
    }
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }

}