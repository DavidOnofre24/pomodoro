part of 'timer_cubit.dart';

class TimerState extends Equatable {
  final Duration duration;
  final Duration timeRemaining;
  final TimerStatus status;
  final TimerType timerType;

  const TimerState({
    required this.duration,
    required this.timeRemaining,
    required this.status,
    required this.timerType,
  });

  static TimerState initial(Duration duration) {
    return TimerState(
      duration: duration,
      timeRemaining: duration,
      status: TimerStatus.stopped,
      timerType: TimerType.pomodoro,
    );
  }

  @override
  List<Object> get props => [
        duration,
        timeRemaining,
        status,
        timerType,
      ];
  TimerState copyWith(
      {Duration? duration, Duration? timeRemaining, TimerStatus? status}) {
    return TimerState(
      duration: duration ?? this.duration,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      status: status ?? this.status,
      timerType: timerType,
    );
  }
}
