import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageDatasource {
  final SharedPreferences sharedPreferences;

  LocalStorageDatasource(this.sharedPreferences);

  Future<void> saveData(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  Future<String?> getData(String key) async {
    return sharedPreferences.getString(key);
  }

  Future<int?> getFinishedLongBreaks() async {
    return sharedPreferences.getInt('finishedLongBreaks');
  }

  Future<int?> getFinishedPomodoros() async {
    return sharedPreferences.getInt('finishedPomodoros');
  }

  Future<int?> getFinishedShortBreaks() async {
    return sharedPreferences.getInt('finishedShortBreaks');
  }

  Future<int?> getMinutesLongBreaks() async {
    return sharedPreferences.getInt('minutesLongBreaks');
  }

  Future<int?> getMinutesPomodoros() async {
    return sharedPreferences.getInt('minutesPomodoros');
  }

  Future<int?> getMinutesShortBreaks() async {
    return sharedPreferences.getInt('minutesShortBreaks');
  }

  Future<void> saveFinishedLongBreaks(int minutes) async {
    final finishedLongBreaks = (await getFinishedLongBreaks() ?? 0) + 1;

    await sharedPreferences.setInt('finishedLongBreaks', finishedLongBreaks);
    await sharedPreferences.setInt('minutesLongBreaks', minutes);
  }

  Future<void> saveFinishedPomodoros(int minutes) async {
    final finishedPomodoros = (await getFinishedPomodoros() ?? 0) + 1;
    await sharedPreferences.setInt('finishedPomodoros', finishedPomodoros);
    await sharedPreferences.setInt('minutesPomodoros', minutes);
  }

  Future<void> saveFinishedShortBreaks(int minutes) async {
    final finishedShortBreaks = (await getFinishedShortBreaks() ?? 0) + 1;
    await sharedPreferences.setInt('finishedShortBreaks', finishedShortBreaks);
    await sharedPreferences.setInt('minutesShortBreaks', minutes);
  }
}
