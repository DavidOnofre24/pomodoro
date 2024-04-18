import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/presentacion/providers/timer/cubit/timer_cubit.dart';
import 'package:pomodoro/presentacion/screens/screen.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      path: '/home/:pageIndex',
      name: HomeScreen.name,
      builder: (context, state) => BlocProvider(
        create: (context) => TimerCubit(duration: const Duration(minutes: 25)),
        child: HomeScreen(
          pageIndex: int.parse(state.pathParameters['pageIndex'] ?? '0'),
        ),
      ),
    )
  ],
);
