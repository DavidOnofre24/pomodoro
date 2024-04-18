import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  final Duration duration;
  late Timer _timer;

  TimerCubit({required this.duration})
      : super(TimerState(
          duration: duration,
          timeRemaining: duration,
          status: TimerStatus.stopped,
        ));

  void resumeTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _timerTicked();
    });
  }

  void pauseTimer() {
    emit(state.copyWith(status: TimerStatus.paused));
    _timer.cancel();
  }

  void startTimer({Duration? duration}) {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _timerTicked();
    });
    emit(TimerState(
      duration: duration ?? this.duration,
      timeRemaining: duration ?? this.duration,
      status: TimerStatus.running,
    ));
  }

  void resetTimer() {
    _timer.cancel();
    emit(const TimerState(
      duration: Duration.zero,
      timeRemaining: Duration.zero,
      status: TimerStatus.stopped,
    ));
  }

  void _timerTicked() {
    final currentState = state;
    final newTimeRemaining =
        currentState.timeRemaining - const Duration(seconds: 1);
    if (newTimeRemaining >= Duration.zero) {
      emit(TimerState(
        duration: currentState.duration,
        timeRemaining: newTimeRemaining,
        status: TimerStatus.running,
      ));
    } else {
      emit(TimerState(
        duration: duration,
        timeRemaining: duration,
        status: TimerStatus.stopped,
      ));
      _timer.cancel();
      return;
    }
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
