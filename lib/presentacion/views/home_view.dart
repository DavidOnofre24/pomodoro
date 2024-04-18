import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/config/constants/colors.dart';
import 'package:pomodoro/presentacion/providers/timer/cubit/timer_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hola, Jackson', style: TextStyle(fontSize: 30)),
            const SizedBox(height: 50),
            Container(
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
                  MaterialButton(
                    color: CustomColors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    onPressed: () {},
                    child: const Text(
                      'Pomodoro',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ),
                  MaterialButton(
                    color: Colors.grey[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    onPressed: () {},
                    child: const Text(
                      'Short break',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  MaterialButton(
                    color: Colors.grey[700],
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Long break',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<TimerCubit, TimerState>(
                    bloc: context.read<TimerCubit>(),
                    builder: (context, state) {
                      if (state.status == TimerStatus.running) {
                        return Column(
                          children: [
                            Center(
                              child: Text(
                                  '${state.timeRemaining.inMinutes.toString()}:${state.timeRemaining.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                                  style: const TextStyle(fontSize: 80)),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1),
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
                          ],
                        );
                      }
                      return Column(
                        children: [
                          Center(
                            child: Text(
                                '${state.timeRemaining.inMinutes.toString()}:${state.timeRemaining.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                                style: const TextStyle(fontSize: 80)),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1),
                          Column(
                            children: [
                              MaterialButton(
                                padding: const EdgeInsets.all(40),
                                color: CustomColors.pink,
                                onPressed: () {
                                  if (state.status == TimerStatus.paused) {
                                    context.read<TimerCubit>().resumeTimer();
                                  } else {
                                    context.read<TimerCubit>().startTimer();
                                  }
                                },
                                shape: const CircleBorder(),
                                child: Icon(
                                  Icons.play_arrow_outlined,
                                  size: 50,
                                  color: Colors.grey[800],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                (state.status == TimerStatus.paused)
                                    ? 'Resume'
                                    : 'Start',
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
