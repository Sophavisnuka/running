import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:running_app/core/theme/app_theme.dart';

class MapTile extends StatelessWidget {
  const MapTile({
    super.key,
    required this.onTap,
    required this.center,
    this.height,
  });

  final double? height;
  final LatLng center;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: height ?? 200,
          child: FlutterMap(
            options: MapOptions(
              initialCenter: center,
              initialZoom: 15,
              // interactionOptions: const InteractionOptions(
              //   flags: InteractiveFlag.none,
              // ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.running_app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: center,
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
        ),
      ),
    );
  }
}