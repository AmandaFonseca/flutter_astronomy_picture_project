import 'package:astronomy_picture/domain/entities/apod.dart';

class ApodModel extends Apod {
  const ApodModel({
    super.title,
    super.copyright,
    super.date,
    super.explanation,
    super.hdurl,
    super.mediaType,
    super.serviceVersion,
    super.url,
    super.thumbnailUrl,
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
    thumbnailUrl: json["thumbnail_url"],
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'copyright': copyright,
    'date': date?.toIso8601String(),
    'explanation': explanation,
    'hdurl': hdurl,
    'media_type': mediaType,
    'service_version': serviceVersion,
    'url': url,
    'thumbnail_url': thumbnailUrl,
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
    thumbnailUrl: thumbnailUrl,
  );

  factory ApodModel.fromEntity(Apod entity) => ApodModel(
    title: entity.title,
    copyright: entity.copyright,
    date: entity.date,
    explanation: entity.explanation,
    hdurl: entity.hdurl,
    mediaType: entity.mediaType,
    serviceVersion: entity.serviceVersion,
    url: entity.url,
    thumbnailUrl: entity.thumbnailUrl,
  );
}
