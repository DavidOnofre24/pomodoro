import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/config/dependency_injection/dependency_injection.dart';
import 'package:pomodoro/presentacion/providers/statistics/cubit/statistics_cubit.dart';
import 'package:pomodoro/presentacion/providers/timer/cubit/timer_cubit.dart';
import 'package:pomodoro/presentacion/screens/screen.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      path: '/home/:pageIndex',
      name: HomeScreen.name,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TimerCubit(
              saveDataRepository: getIt.get(),
              statisticsRepository: getIt.get(),
              duration: const Duration(minutes: 25),
            ),
          ),
          BlocProvider(
            create: (context) => StatisticsCubit(
              getStatisticsUseCase: getIt.get(),
            )..init(),
          ),
        ],
        child: HomeScreen(
          pageIndex: int.parse(state.pathParameters['pageIndex'] ?? '0'),
        ),
      ),
    )
  ],
);
