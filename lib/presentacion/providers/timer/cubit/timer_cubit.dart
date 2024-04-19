import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pomodoro/domain/entities/timer.dart';
import 'package:pomodoro/domain/repositories/save_data_repository.dart';
import 'package:pomodoro/domain/repositories/statistics_repository.dart';
import 'package:audioplayers/audioplayers.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  final SaveDataRepository saveDataRepository;
  final StatisticsRepository statisticsRepository;
  Duration duration;
  late Timer _timer;

  TimerCubit({
    required this.duration,
    required this.saveDataRepository,
    required this.statisticsRepository,
  }) : super(TimerState.initial(duration)) {
    saveDataRepository.getTimePomodoro().then((value) {
      if (value != null) {
        initTimer(timerType: TimerType.pomodoro);
      }
    });
  }

  void resumeTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _timerTicked();
    });
  }

  void pauseTimer() {
    emit(state.copyWith(status: TimerStatus.paused));
    _timer.cancel();
  }

  void initTimer({TimerType? timerType}) async {
    if (state.status != TimerStatus.stopped) {
      _timer.cancel();
    }
    duration = const Duration(minutes: 25);
    switch (timerType) {
      case TimerType.pomodoro:
        final pomodoro = await saveDataRepository.getTimePomodoro();
        if (pomodoro != null) {
          duration = Duration(minutes: int.parse(pomodoro));
        } else {
          duration = const Duration(minutes: 25);
        }

        break;
      case TimerType.shortBreak:
        final shortBreak = await saveDataRepository.getTimeShortBreak();
        if (shortBreak != null) {
          duration = Duration(minutes: int.parse(shortBreak));
        } else {
          duration = const Duration(minutes: 5);
        }
        break;
      case TimerType.longBreak:
        final longBreak = await saveDataRepository.getTimeLongBreak();
        if (longBreak != null) {
          duration = Duration(minutes: int.parse(longBreak));
        } else {
          duration = const Duration(minutes: 15);
        }
        break;
      default:
        break;
    }
    emit(TimerState(
      duration: duration,
      timeRemaining: duration,
      status: TimerStatus.stopped,
      timerType: timerType ?? state.timerType,
    ));
  }

  void startTimer({
    Duration? duration,
  }) {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _timerTicked();
    });
    emit(state.copyWith(
      duration: duration ?? this.duration,
      timeRemaining: duration ?? this.duration,
      status: TimerStatus.running,
    ));
  }

  void resetTimer() {
    _timer.cancel();
    emit(state.copyWith(
      duration: duration,
      timeRemaining: duration,
      status: TimerStatus.stopped,
    ));
  }

  void _timerTicked() {
    final currentState = state;
    final newTimeRemaining =
        currentState.timeRemaining - const Duration(seconds: 1);
    if (newTimeRemaining >= Duration.zero) {
      emit(state.copyWith(
        duration: currentState.duration,
        timeRemaining: newTimeRemaining,
        status: TimerStatus.running,
      ));
    } else {
      final player = AudioPlayer();
      player.play(AssetSource('song.mp3'));
      saveTime(
          currentState.timerType, currentState.duration.inMinutes.toString());
      emit(state.copyWith(
        duration: duration,
        timeRemaining: duration,
        status: TimerStatus.stopped,
      ));
      _timer.cancel();
      return;
    }
  }

  void saveTime(TimerType timerType, String data) {
    switch (timerType) {
      case TimerType.pomodoro:
        statisticsRepository.saveFinishedPomodoros(state.duration.inMinutes);
        break;
      case TimerType.shortBreak:
        statisticsRepository.saveFinishedShortBreaks(state.duration.inMinutes);
        break;
      case TimerType.longBreak:
        statisticsRepository.saveFinishedLongBreaks(state.duration.inMinutes);
        break;
    }
    initTimer(timerType: timerType);
  }

  void saveMinutes(TimerType timerType, String data) {
    switch (timerType) {
      case TimerType.pomodoro:
        saveDataRepository.saveTime('pomodoro', data);
        break;
      case TimerType.shortBreak:
        saveDataRepository.saveTime('shortBreak', data);
        break;
      case TimerType.longBreak:
        saveDataRepository.saveTime('longBreak', data);
        break;
    }
    initTimer(timerType: timerType);
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
