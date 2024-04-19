import 'dart:async';

import 'package:pomodoro/domain/entities/statistic.dart';
import 'package:pomodoro/domain/entities/timer.dart';
import 'package:pomodoro/domain/repositories/statistics_repository.dart';

class GetStatisticsUseCase {
  final StatisticsRepository repository;

  GetStatisticsUseCase(this.repository);

  Future<List<Statistic>> call() async {
    final finishedLongBreaks = await repository.getFinishedLongBreaks();
    final finishedPomodoros = await repository.getFinishedPomodoros();
    final finishedShortBreaks = await repository.getFinishedShortBreaks();
    final minutesLongBreaks = await repository.getMinutesLongBreaks();
    final minutesPomodoros = await repository.getMinutesPomodoros();
    final minutesShortBreaks = await repository.getMinutesShortBreaks();

    final statistics = [
      Statistic(
        completedCycles: finishedPomodoros ?? 0,
        timerType: TimerType.pomodoro,
        minutes: minutesPomodoros ?? 0,
      ),
      Statistic(
        completedCycles: finishedShortBreaks ?? 0,
        timerType: TimerType.shortBreak,
        minutes: minutesShortBreaks ?? 0,
      ),
      Statistic(
        completedCycles: finishedLongBreaks ?? 0,
        timerType: TimerType.longBreak,
        minutes: minutesLongBreaks ?? 0,
      ),
    ];
    return statistics;
  }
}
