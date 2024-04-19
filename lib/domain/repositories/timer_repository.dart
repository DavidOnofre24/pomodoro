abstract class TimerRepository {
  Future<void> startTimer();

  Future<void> stopTimer();

  Future<void> resetTimer();

  Stream<int> get timerStream;

  void dispose();

  void setDuration(int duration);
}
