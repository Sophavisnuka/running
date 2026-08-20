import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:running_app/data/repositories/location_repository.dart';

enum LocationLoadStatus { loading, success, error }

class LocationViewModel extends ChangeNotifier {
  final LocationRepository _locationRepository;

  LocationViewModel({LocationRepository? locationRepository}) : _locationRepository = locationRepository ?? LocationRepository();

  LocationLoadStatus _status = LocationLoadStatus.loading;
  Position? _currentPosition;
  String? _errorMessage;

  LocationLoadStatus get status => _status;
  Position? get currentPosition => _currentPosition;
  String? get errorMessage => _errorMessage;

  /// Call once when the screen loads (e.g. from initState, or the constructor
  /// of a Provider that's created fresh per screen).
  Future<void> loadCurrentLocation() async {
    _status = LocationLoadStatus.loading;
    notifyListeners();

    try {
      _currentPosition = await _locationRepository.getCurrentLocation();
      _status = LocationLoadStatus.success;
    } catch (e) {
      _errorMessage = e.toString();
      _status = LocationLoadStatus.error;
    }

    notifyListeners();
  }
  /// Call this if a screen wants to force a fresh lookup
  /// (e.g. a retry button after permission was denied).
  Future<void> refresh() => loadCurrentLocation();
}