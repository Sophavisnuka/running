import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/core/theme/app_theme.dart';
import 'package:running_app/presentation/screens/running_screen/map_screen.dart';
import 'package:running_app/presentation/view_model/location_vm.dart';
import 'package:running_app/presentation/widgets/map_tile.dart';
import 'package:running_app/presentation/widgets/stat_tile.dart';
import 'package:latlong2/latlong.dart';

class RunningScreen extends StatelessWidget {
  const RunningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationViewModel = context.watch<LocationViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Start Run',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Headline stat — Distance is the hero number
              Column(
                children: [
                  Text(
                    '0.00',
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey.shade900,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'KILOMETERS',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Secondary stats — Time & Pace side by side
              Row(
                children: [
                  Expanded(
                    child: StatTile(
                      icon: Icons.timer_outlined,
                      label: 'Time',
                      value: '00:00',
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: StatTile(
                      icon: Icons.speed_outlined,
                      label: 'Pace',
                      value: '--:-- /km',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              MapTile(
                center: locationViewModel.status == LocationLoadStatus.error
                  ? const LatLng(11.5564, 104.9282) // fallback: Phnom Penh
                  : LatLng(
                      locationViewModel.currentPosition!.latitude,
                      locationViewModel.currentPosition!.longitude,
                    ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MapScreen(),
                    ),
                  );
                },
              ),
              const Spacer(),
              // Start button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MapScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.play_arrow_rounded, size: 26),
                  label: const Text(
                    'Start Run',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}