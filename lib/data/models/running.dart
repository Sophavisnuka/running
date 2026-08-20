import 'package:geolocator/geolocator.dart';

class RunModel {
  final double distance;
  final double pace;
  final Duration duration;
  final DateTime date;
  final Geolocator? startLocation;
  final Geolocator? endLocation;
  final String? notes;
  final String? title;
  final int? totalRuns;

  const RunModel({
    required this.distance,
    required this.pace,
    required this.duration,
    required this.date,
    this.startLocation,
    this.endLocation,
    this.notes,
    this.title,
    this.totalRuns,
  });
}