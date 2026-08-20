import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:running_app/data/repositories/running_repository.dart';
import 'package:running_app/data/models/running.dart';
import 'package:running_app/presentation/screens/activities_screen.dart';
import 'package:running_app/presentation/screens/home_screen/widgets/running_card.dart';
import 'package:running_app/presentation/screens/home_screen/widgets/stat_card.dart';
import 'package:running_app/presentation/screens/running_screen/map_screen.dart';
import 'package:running_app/presentation/view_model/location_vm.dart';
import 'package:running_app/presentation/widgets/map_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationVm = context.watch<LocationViewModel>();
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello, Sophavisnuka',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            StatsCard(
              statsByPeriod: {
                StatsPeriod.week: RunningRepository(
                  run: RunModel(
                    distance: 12.4,
                    pace: 0,
                    duration: const Duration(hours: 1, minutes: 22),
                    totalRuns: 3,
                    date: DateTime.now(),
                  ),
                ),
                StatsPeriod.month: RunningRepository(
                  run: RunModel(
                    distance: 48.7,
                    pace: 0,
                    duration: const Duration(hours: 5, minutes: 10),
                    totalRuns: 10,
                    date: DateTime.now(),
                  ),
                ),
                StatsPeriod.allTime: RunningRepository(
                  run: RunModel(
                    distance: 210.5,
                    pace: 0,
                    duration: const Duration(hours: 22, minutes: 45),
                    totalRuns: 15,
                    date: DateTime.now(),
                  ),
                ),
              },
            ),
            const SizedBox(height: 10),
            const Text(
              'Current Location',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildLocationMap(context, locationVm),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Runs',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ActivitiesScreen()),
                    );
                  },
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4, // Replace with the actual number of recent runs
              itemBuilder: (context, index) {
                return const RunningCard();
              },
            ),
          ],
        ),
      ],
    );
  }
  /// Builds the "Current Location" map preview based on LocationViewModel's
  /// current status — loading spinner, real map, or fallback on error.
  Widget _buildLocationMap(BuildContext context, LocationViewModel locationViewModel) {
    if (locationViewModel.status == LocationLoadStatus.loading) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    final center = locationViewModel.status == LocationLoadStatus.error
      ? const LatLng(11.5564, 104.9282) // fallback: Phnom Penh
      : LatLng(
          locationViewModel.currentPosition!.latitude,
          locationViewModel.currentPosition!.longitude,
        );

    return MapTile(
      center: center,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MapScreen()),
        );
      },
    );
  }
}