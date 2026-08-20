import 'package:running_app/data/models/running.dart';

class RunningRepository {
  final RunModel run;

  const RunningRepository({required this.run});
  /// Average pace in minutes per km (e.g. 5.5 = 5:30/km).
  double get avgPaceMinPerKm {
    if (run.distance == 0) return 0;
    return run.duration.inSeconds / 60 / run.distance;
  }

  String get formattedTime {
    final hours = run.duration.inHours;
    final minutes = run.duration.inMinutes.remainder(60);
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  String get formattedPace {
    if (run.distance == 0) return '--:--';
    final pace = avgPaceMinPerKm;
    final min = pace.floor();
    final sec = ((pace - min) * 60).round();
    return '$min:${sec.toString().padLeft(2, '0')} /km';
  }
}