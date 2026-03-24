import 'package:equatable/equatable.dart';

class Apod extends Equatable {
  final String? copyright;
  final DateTime? date;
  final String? explanation;
  final String? hdurl;
  final String? mediaType;
  final String? serviceVersion;
  final String? title;
  final String? url;
  final String? thumbnailUrl;

  const Apod({
    this.copyright,
    this.date,
    this.explanation,
    this.hdurl,
    this.mediaType,
    this.serviceVersion,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  @override
  List<Object?> get props => [
    copyright,
    date,
    explanation,
    hdurl,
    mediaType,
    serviceVersion,
    title,
    url,
    thumbnailUrl,
  ];
}
