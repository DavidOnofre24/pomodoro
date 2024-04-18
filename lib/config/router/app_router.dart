import 'package:go_router/go_router.dart';
import 'package:pomodoro/presentacion/screens/screen.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      path: '/home/:pageIndex',
      name: HomeScreen.name,
      builder: (context, state) => HomeScreen(
        pageIndex: int.parse(state.pathParameters['pageIndex'] ?? '0'),
      ),
    )
  ],
);
