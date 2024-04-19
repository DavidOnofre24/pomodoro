import 'package:pomodoro/domain/repositories/statistics_repository.dart';
import 'package:pomodoro/infrastructure/datasource/local_storage_datasource.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  final LocalStorageDatasource datasource;

  StatisticsRepositoryImpl({required this.datasource});

  @override
  Future<int?> getFinishedLongBreaks() {
    return datasource.getFinishedLongBreaks();
  }

  @override
  Future<int?> getFinishedPomodoros() {
    return datasource.getFinishedPomodoros();
  }

  @override
  Future<int?> getFinishedShortBreaks() {
    return datasource.getFinishedShortBreaks();
  }

  @override
  Future<int?> getMinutesLongBreaks() {
    return datasource.getMinutesLongBreaks();
  }

  @override
  Future<int?> getMinutesPomodoros() {
    return datasource.getMinutesPomodoros();
  }

  @override
  Future<int?> getMinutesShortBreaks() {
    return datasource.getMinutesShortBreaks();
  }

  @override
  Future<void> saveFinishedLongBreaks(int minutes) {
    return datasource.saveFinishedLongBreaks(minutes);
  }

  @override
  Future<void> saveFinishedPomodoros(int minutes) {
    return datasource.saveFinishedPomodoros(minutes);
  }

  @override
  Future<void> saveFinishedShortBreaks(int minutes) {
    return datasource.saveFinishedShortBreaks(minutes);
  }
}
