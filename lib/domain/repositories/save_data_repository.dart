abstract class SaveDataRepository {
  Future<void> saveTime(String key, String data);

  Future<String?> getTimePomodoro();

  Future<String?> getTimeShortBreak();

  Future<String?> getTimeLongBreak();
}
