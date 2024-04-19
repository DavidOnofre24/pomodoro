import 'package:pomodoro/domain/entities/timer.dart';

class Statistic {
  final TimerType timerType;
  final int minutes;
  final int completedCycles;

  Statistic({
    required this.timerType,
    required this.minutes,
    required this.completedCycles,
  });
}
