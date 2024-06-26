import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/config/constants/colors.dart';
import 'package:pomodoro/domain/entities/timer.dart';
import 'package:pomodoro/presentacion/providers/timer/cubit/timer_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocBuilder<TimerCubit, TimerState>(
          bloc: context.read<TimerCubit>(),
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Hola, Jackson', style: TextStyle(fontSize: 30)),
                const SizedBox(height: 50),
                RowButtons(
                  timerType: state.timerType,
                ),
                TimerWidget(
                  state: state,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class RowButtons extends StatelessWidget {
  final TimerType timerType;
  const RowButtons({
    required this.timerType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[900],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomButton(
            isSelected: timerType == TimerType.pomodoro,
            label: 'Pomodoro',
            onPressed: () {
              context.read<TimerCubit>().initTimer(
                    timerType: TimerType.pomodoro,
                  );
            },
          ),
          CustomButton(
            isSelected: timerType == TimerType.shortBreak,
            label: 'Short break',
            onPressed: () {
              context.read<TimerCubit>().initTimer(
                    timerType: TimerType.shortBreak,
                  );
            },
          ),
          CustomButton(
            isSelected: timerType == TimerType.longBreak,
            label: 'Long break',
            onPressed: () {
              context.read<TimerCubit>().initTimer(
                    timerType: TimerType.longBreak,
                  );
            },
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool isSelected;
  final String label;

  const CustomButton({
    required this.onPressed,
    required this.isSelected,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: (isSelected) ? CustomColors.pink : Colors.grey[700],
      padding: const EdgeInsets.symmetric(vertical: 13),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: (isSelected) ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}

class TimerWidget extends StatelessWidget {
  final TimerState state;
  const TimerWidget({
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Builder(
            builder: (_) {
              if (state.status == TimerStatus.running) {
                return RunningTimer(state: state);
              }
              if (state.status == TimerStatus.stopped) {
                return StoppedTimer(state: state);
              }

              return PauseTimer(state: state);
            },
          ),
        ],
      ),
    );
  }
}

class StoppedTimer extends StatelessWidget {
  final TimerState state;
  const StoppedTimer({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
              '${state.timeRemaining.inMinutes.toString()}:${state.timeRemaining.inSeconds.remainder(60).toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 80)),
        ),
        TextButton(
            onPressed: () {
              showMinutesInput(context);
            },
            child: const Icon(Icons.edit, color: CustomColors.pink)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Column(
          children: [
            MaterialButton(
              padding: const EdgeInsets.all(40),
              color: CustomColors.pink,
              onPressed: () {
                context.read<TimerCubit>().startTimer();
              },
              shape: const CircleBorder(),
              child: Icon(
                Icons.play_arrow_outlined,
                size: 50,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Start',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> showMinutesInput(BuildContext context) {
    String values = '';
    return showDialog(
      context: context,
      builder: (_) {
        return Theme(
          data: ThemeData.from(
            colorScheme: const ColorScheme.dark(primary: CustomColors.pink),
          ),
          child: AlertDialog(
            shadowColor: Colors.grey[900],
            backgroundColor: Colors.grey[900],
            title: const Text('Seleccione los minutos'),
            content: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(labelText: 'Minutos'),
              onChanged: (value) {
                values = value;
              },
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  if (values.isEmpty) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Debe ingresar los minutos',
                            style: TextStyle(color: Colors.white)),
                      ),
                    );
                    return;
                  }
                  context.read<TimerCubit>().saveMinutes(
                        state.timerType,
                        values,
                      );

                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class RunningTimer extends StatelessWidget {
  const RunningTimer({
    super.key,
    required this.state,
  });

  final TimerState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
              '${state.timeRemaining.inMinutes.toString()}:${state.timeRemaining.inSeconds.remainder(60).toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 80)),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                MaterialButton(
                  padding: const EdgeInsets.all(40),
                  color: CustomColors.pink,
                  onPressed: () {
                    context.read<TimerCubit>().pauseTimer();
                  },
                  shape: const CircleBorder(),
                  child: Icon(
                    Icons.pause_outlined,
                    size: 50,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Pause',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                MaterialButton(
                  padding: const EdgeInsets.all(40),
                  color: CustomColors.pink,
                  onPressed: () {
                    context.read<TimerCubit>().resetTimer();
                  },
                  shape: const CircleBorder(),
                  child: Icon(
                    Icons.stop_outlined,
                    size: 50,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class PauseTimer extends StatelessWidget {
  const PauseTimer({
    super.key,
    required this.state,
  });

  final TimerState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
              '${state.timeRemaining.inMinutes.toString()}:${state.timeRemaining.inSeconds.remainder(60).toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 80)),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Column(
          children: [
            MaterialButton(
              padding: const EdgeInsets.all(40),
              color: CustomColors.pink,
              onPressed: () {
                context.read<TimerCubit>().resumeTimer();
              },
              shape: const CircleBorder(),
              child: Icon(
                Icons.play_arrow_outlined,
                size: 50,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Resume',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
