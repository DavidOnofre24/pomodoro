part of 'timer_cubit.dart';

enum TimerStatus { running, paused, stopped }

class TimerState extends Equatable {
  final Duration duration;
  final Duration timeRemaining;
  final TimerStatus status;

  const TimerState(
      {required this.duration,
      required this.timeRemaining,
      required this.status});

  @override
  List<Object> get props => [
        duration,
        timeRemaining,
        status,
      ];
  TimerState copyWith(
      {Duration? duration, Duration? timeRemaining, TimerStatus? status}) {
    return TimerState(
        duration: duration ?? this.duration,
        timeRemaining: timeRemaining ?? this.timeRemaining,
        status: status ?? this.status);
  }
}
