import 'Data.dart';
import '@meta.dart';

/// status : "ok"
/// status_message : "Query was successful"
/// data : {"movie":{"id":78137,"url":"https://yts.gg/movies/soumsoum-la-nuit-des-astres-2026","imdb_code":"tt39075020","title":"Soumsoum, la nuit des astres","title_english":"Soumsoum, la nuit des astres","title_long":"Soumsoum, la nuit des astres (2026)","slug":"soumsoum-la-nuit-des-astres-2026","year":2026,"rating":6.3,"runtime":101,"genres":["Action","Adventure","Drama","Fantasy","Romance","Sci-Fi"],"like_count":3,"description_intro":"A 17-year-old named Kellou discovers unexplained supernatural powers. Meeting Aya transforms her confusion into a mystical journey where visible and invisible realms meet.","description_full":"A 17-year-old named Kellou discovers unexplained supernatural powers. Meeting Aya transforms her confusion into a mystical journey where visible and invisible realms meet.","yt_trailer_code":"hzb6nXtUcI4","language":"fr","mpa_rating":"","background_image":"https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/background.jpg","background_image_original":"https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/background.jpg","small_cover_image":"https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/small-cover.jpg","medium_cover_image":"https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/medium-cover.jpg","large_cover_image":"https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/large-cover.jpg","medium_screenshot_image1":"https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/medium-screenshot1.jpg","medium_screenshot_image2":"https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/medium-screenshot2.jpg","medium_screenshot_image3":"https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/medium-screenshot3.jpg","large_screenshot_image1":"https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/large-screenshot1.jpg","large_screenshot_image2":"https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/large-screenshot2.jpg","large_screenshot_image3":"https://yts.gg/assets/images/movies/soumsoum_la_nuit_des_astres_2026/large-screenshot3.jpg","cast":[{"name":"Eriq Ebouaney","character_name":"Garba","url_small_image":"https://yts.gg/assets/images/actors/thumb/nm0248254.jpg","imdb_code":"0248254"},{"name":"Achouackh Abakar Souleymane","character_name":"Aya","imdb_code":"6178643"},{"name":"Maïmouna Miawama","character_name":"Kellou","imdb_code":"17935224"},{"name":"Brigitte Tchanegue","character_name":"Aïcha","imdb_code":"17144014"}],"torrents":[{"url":"https://yts.gg/torrent/download/99A655F052C1D17DA043C0D96EA034C5158A2E6B","hash":"99A655F052C1D17DA043C0D96EA034C5158A2E6B","quality":"720p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"931.47 MB","size_bytes":976717087,"date_uploaded":"2026-08-26 12:01:50","date_uploaded_unix":1787738510},{"url":"https://yts.gg/torrent/download/89A8455A370EC25451F3B1C764ED82CB21DDFC1D","hash":"89A8455A370EC25451F3B1C764ED82CB21DDFC1D","quality":"1080p","type":"web","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"5.1","seeds":0,"peers":0,"size":"1.87 GB","size_bytes":2007897211,"date_uploaded":"2026-08-26 12:58:25","date_uploaded_unix":1787741905}],"date_uploaded":"2026-08-26 12:01:50","date_uploaded_unix":1787738510}}
/// @meta : {"api_version":2,"execution_time":"0 ms"}

class MovieDetails {
  MovieDetails({
      this.status, 
      this.statusMessage, 
      this.data, 
      this.meta,});

  MovieDetails.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? Meta.fromJson(json['@meta']) : null;
  }
  String? status;
  String? statusMessage;
  Data? data;
  Meta? meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (meta != null) {
      map['@meta'] = meta?.toJson();
    }
    return map;
  }

}