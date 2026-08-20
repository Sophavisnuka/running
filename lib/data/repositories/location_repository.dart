import 'package:geolocator/geolocator.dart';
import 'package:running_app/core/service/location_permission.dart';

class LocationRepository {
  /// Checks that location services are on and permission is granted.
  /// Throws LocationPermissionException if not — the caller decides what to do with that.
  Future<void> _ensurePermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationPermissionException(
        'Location services are disabled. Please enable them in your device settings.',
      );
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationPermissionException('Location permission was denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionException(
        'Location permission is permanently denied. Please enable it in app settings.',
      );
    }
  }

  /// One-time location lookup — used for the HomeScreen map preview.
  Future<Position> getCurrentLocation() async {
    await _ensurePermission();
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationPermissionException(
        'Location services are disabled. Please enable them in your device settings.',
      );
    }
    return Geolocator.getCurrentPosition();
  }
}