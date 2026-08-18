import 'package:flutter/material.dart';

class RunningCard extends StatelessWidget {
  const RunningCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 243, 93, 33),   // border color
          width: 1.5,           // border thickness
        ),
        borderRadius: BorderRadius.circular(12), // rounded corners
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