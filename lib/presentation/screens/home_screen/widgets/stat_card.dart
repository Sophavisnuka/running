import 'package:flutter/material.dart';
import 'package:running_app/core/theme/app_theme.dart';
import 'package:running_app/data/repositories/running_repository.dart';
import 'package:running_app/data/models/running.dart';
import 'package:running_app/presentation/widgets/stat_tile.dart';

/// Time period options for the stats card.
enum StatsPeriod { week, month, allTime }
class StatsCard extends StatefulWidget {
  /// Provide stats for each period. Pass whatever you have; missing
  /// periods will just show zeros.
  final Map<StatsPeriod, RunningRepository> statsByPeriod;

  const StatsCard({super.key, required this.statsByPeriod});

  @override
  State<StatsCard> createState() => _StatsCardState();
}

class _StatsCardState extends State<StatsCard> {
  StatsPeriod _selected = StatsPeriod.week;

  static const _labels = {
    StatsPeriod.week: 'This Week',
    StatsPeriod.month: 'This Month',
    StatsPeriod.allTime: 'All Time',
  };

  @override
  Widget build(BuildContext context) {
    final stats = widget.statsByPeriod[_selected] ?? RunningRepository(run: RunModel(distance: 0, pace: 0, duration: Duration.zero, date: DateTime.now()));

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPeriodToggle(),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: StatTile(
                  icon: Icons.route_outlined,
                  label: 'Distance',
                  value: '${stats.run.distance.toStringAsFixed(1)} km',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatTile(
                  icon: Icons.timer_outlined,
                  label: 'Time',
                  value: stats.formattedTime,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: StatTile(
                  icon: Icons.directions_run,
                  label: 'Runs',
                  value: '${stats.run.totalRuns}',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatTile(
                  icon: Icons.speed_outlined,
                  label: 'Avg Pace',
                  value: stats.formattedPace,
                ),
              ),
            ],
          ),
        ],
      );
  }

  Widget _buildPeriodToggle() {
    return Container(
      // padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: StatsPeriod.values.map((period) {
          final isSelected = period == _selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selected = period),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  _labels[period]!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
