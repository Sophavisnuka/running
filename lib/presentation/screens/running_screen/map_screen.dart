import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:running_app/core/theme/app_theme.dart';
import 'package:running_app/presentation/view_model/location_vm.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationViewModel = context.watch<LocationViewModel>();
    final isReady = locationViewModel.status == LocationLoadStatus.success && locationViewModel.currentPosition != null;
    final currentLocation = isReady
        ? LatLng(locationViewModel.currentPosition!.latitude, locationViewModel.currentPosition!.longitude)
        : const LatLng(11.5564, 104.9282); // fallback: Phnom Penh
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
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: currentLocation, // fallback: Phnom Penh
          initialZoom: 15,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
            ]
          ),
        ],
      ),
    );
  }
}