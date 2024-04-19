abstract class StatisticsRepository {
  Future<void> saveFinishedPomodoros(int minutes);

  Future<int?> getMinutesPomodoros();

  Future<int?> getFinishedPomodoros();

  Future<void> saveFinishedShortBreaks(int minutes);

  Future<int?> getMinutesShortBreaks();

  Future<int?> getFinishedShortBreaks();

  Future<void> saveFinishedLongBreaks(int minutes);

  Future<int?> getMinutesLongBreaks();

  Future<int?> getFinishedLongBreaks();
}
