import 'package:flutter_astronomy_picture_project/domain/entities/apod.dart';

class ApodModel {
  final String? title;
  final String? copyright;
  final DateTime? date;
  final String? explanation;
  final String? hdurl;
  final String? mediaType;
  final String? serviceVersion;
  final String? url;

  const ApodModel({
    this.title,
    this.copyright,
    this.date,
    this.explanation,
    this.hdurl,
    this.mediaType,
    this.serviceVersion,
    this.url,
  });

  factory ApodModel.fromJson(Map<String, dynamic> json) => ApodModel(
    title: json['title'],
    copyright: json['copyright'],
    date: DateTime.parse(json['date']),
    explanation: json['explanation'],
    hdurl: json['hdurl'],
    mediaType: json['media_type'],
    serviceVersion: json['service_version'],
    url: json['url'],
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'copyright': copyright,
    'date': date,
    'explanation': explanation,
    'hdurl': hdurl,
    'media_type': mediaType,
    'service_version': serviceVersion,
    'url': url,
  };

  Apod toEntity() => Apod(
    copyright: copyright,
    date: date,
    explanation: explanation,
    hdurl: hdurl,
    mediaType: mediaType,
    serviceVersion: serviceVersion,
    title: title,
    url: url,
  );
}
