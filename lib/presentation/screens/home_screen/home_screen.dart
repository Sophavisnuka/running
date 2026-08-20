import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:running_app/data/repositories/running_repository.dart';
import 'package:running_app/data/models/running.dart';
import 'package:running_app/presentation/screens/home_screen/widgets/stat_card.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hello, Sophavisnuka', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            StatsCard(
              statsByPeriod: {
                StatsPeriod.week: RunningRepository(
                  run: RunModel(
                    distance: 12.4,
                    pace: 0,
                    duration: const Duration(hours: 1, minutes: 22),
                    date: DateTime.now(),
                  ),
                ),
                StatsPeriod.month: RunningRepository(
                  run: RunModel(
                    distance: 48.7,
                    pace: 0,
                    duration: const Duration(hours: 5, minutes: 10),
                    date: DateTime.now(),
                  ),
                ),
                StatsPeriod.allTime: RunningRepository(
                  run: RunModel(
                    distance: 210.5,
                    pace: 0,
                    duration: const Duration(hours: 22, minutes: 45),
                    date: DateTime.now(),
                  ),
                ),
              },
            ),
            SizedBox(height: 10),
            Text('Current Location', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 200,
                child: FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(11.5564, 104.9282),
                    initialZoom: 15,
                    interactionOptions: InteractionOptions(
                      flags: InteractiveFlag.none, // disable pan/zoom for a preview
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.running_app',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Text('Recent Runs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
          ],
        ),
      ],
    );
  }
}