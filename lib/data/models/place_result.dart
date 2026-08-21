class PlaceResult {
  final String name;
  final double latitude;
  final double longitude;

  PlaceResult({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
  factory PlaceResult.fromJson(Map<String, dynamic> json) {
    return PlaceResult(
      name: json['display_name'] as String,
      latitude: double.parse(json['lat'] as String),
      longitude: double.parse(json['lon'] as String),
    );
  }
}