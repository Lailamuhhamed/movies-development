import 'Data.dart';

class MoviesSource {
  String? status;
  String? statusMessage;
  Data? data;
  Meta? meta;

  MoviesSource({
    this.status,
    this.statusMessage,
    this.data,
    this.meta,
  });

  MoviesSource.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? Meta.fromJson(json['@meta']) : null;
  }

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

class Meta {
  int? apiVersion;
  String? executionTime;

  Meta({
    this.apiVersion,
    this.executionTime,
  });

  Meta.fromJson(dynamic json) {
    apiVersion = json['api_version'];
    executionTime = json['execution_time'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['api_version'] = apiVersion;
    map['execution_time'] = executionTime;
    return map;
  }
}