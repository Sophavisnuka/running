import 'package:flutter/material.dart';
import 'package:running_app/core/theme/app_theme.dart';

class RunningCard extends StatelessWidget {
  const RunningCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.primaryColor,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: const Icon(Icons.directions_run),
            title: const Text('Running Activity', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Text('Distance'),
                    SizedBox(height: 4),
                    Text('5.2 km', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Text('Time'),
                    SizedBox(height: 4),
                    Text('30 min', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Text('Avg pace'),
                    SizedBox(height: 4),
                    Text('5:00 min/km', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            onTap: () {
              // Navigate to detailed running activity screen
            },
          ),
        ),
      ],
    );
  }
}