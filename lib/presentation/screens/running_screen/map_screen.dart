import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:running_app/core/theme/app_theme.dart';
import 'package:running_app/presentation/screens/running_screen/widgets/search_bar.dart';
import 'package:running_app/presentation/view_model/location_vm.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();

  static Widget _buildStat({
    required String value,
    required String unit,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            if (unit.isNotEmpty) ...[
              const SizedBox(width: 3),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),

        const SizedBox(height: 4),

        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  static Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey.shade300,
    );
  }
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController = MapController();
  late LocationViewModel _locationViewModel;
  LatLng? _lastMovedTo;
  @override
  void initState() {
    super.initState();
    _locationViewModel = context.read<LocationViewModel>();
    _locationViewModel.addListener(_handleSearchedLocationChanged);
  }

  void _handleSearchedLocationChanged() {
    final target = _locationViewModel.searchLocation;
    // Only move if this is a new selection, not just any notifyListeners().
    if (target != null && target != _lastMovedTo) {
      _lastMovedTo = target;
      mapController.move(target, 16);
    }
  }

  @override
  void dispose() {
    _locationViewModel.removeListener(_handleSearchedLocationChanged);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final locationViewModel = context.watch<LocationViewModel>();
    final isReady =
      locationViewModel.status == LocationLoadStatus.success &&
      locationViewModel.currentPosition != null;
    final currentLocation = isReady
      ? LatLng(
          locationViewModel.currentPosition!.latitude,
          locationViewModel.currentPosition!.longitude,
        )
      : const LatLng(11.5564, 104.9282);

    final searchedLocation = locationViewModel.searchLocation;
    final searchedLabel = locationViewModel.searchQuery;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 243, 93, 33),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        title: SearchBarWidget(
          onPlaceSelected: (place) => locationViewModel.placeSelected(place)
        )
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: currentLocation,
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.running_app',
              ),

              MarkerLayer(
                markers: [
                  Marker(
                    point: currentLocation,
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_on,
                      color: AppTheme.primaryColor,
                      size: 40,
                    ),
                  ),
                  if (searchedLocation != null)
                    Marker(
                      point: searchedLocation,
                      width: 80,
                      height: 80,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.blueAccent,
                        size: 40,
                      ),
                    ),
                ],
              ),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16,10,16,0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MapScreen._buildStat(value: '0.00',unit: 'km',label: 'Distance',
                    ),
                    MapScreen._buildDivider(),
                    MapScreen._buildStat(value: '00:00',unit: '',label: 'Time',
                    ),
                    MapScreen._buildDivider(),
                    MapScreen._buildStat(value: '--:--',unit: '/km',label: 'Pace',
                    ),
                  ],
                ),
              ),
            ),
          ),
          //bottom control
          //bottom control
          Stack(
            children: [
              if (searchedLabel != null)
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 100, // sits above the button bar
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.place, color: Colors.blueAccent, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            searchedLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.close, size: 16),
                          onPressed: () => _locationViewModel.clearSelectedPlace(),
                        ),
                      ],
                    ),
                  ),
                ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 30,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Pause / Resume
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.pause),
                          label: const Text('Pause'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // End Run
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.stop),
                          label: const Text('End Run'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: FloatingActionButton(
          onPressed: () {
            mapController.move(currentLocation, 15);
          },
          backgroundColor: AppTheme.primaryColor,
          child: const Icon(
            Icons.my_location,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}