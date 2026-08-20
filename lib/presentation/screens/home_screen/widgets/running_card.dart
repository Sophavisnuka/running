import 'package:flutter/material.dart';
import 'package:running_app/core/theme/app_theme.dart';

class RunningCard extends StatelessWidget {
  const RunningCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.primaryColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.directions_run),
        title: const Text('Running Activity'),
        subtitle: const Text('Duration: 30 mins, Distance: 5 km'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          // Navigate to detailed running activity screen
        },
      ),
    );
  }
}