import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/config/constants/colors.dart';
import 'package:pomodoro/presentacion/providers/statistics/cubit/statistics_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: const Column(
          children: [
            Center(
              child: Text(
                'Profile',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            AvatarWidget(),
            SizedBox(height: 20),
            Text('jackson@gmail.com', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            StatisticsWidget(),
          ],
        ),
      ),
    );
  }
}

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DeformedCircleClipper(),
      child: Container(
        padding: const EdgeInsets.all(30),
        color: CustomColors.pink,
        child: const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: Text(
            'J',
            style: TextStyle(
              fontSize: 35,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
        bloc: context.read<StatisticsCubit>(),
        builder: (context, state) {
          if (state.statistics.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ItemStatistic(
                    backgroundColor: CustomColors.pink,
                    title: 'Focus',
                    quantity: state.statistics[0].completedCycles.toString(),
                    minutes: '${state.statistics[0].minutes} min',
                  ),
                  const SizedBox(width: 20),
                  ItemStatistic(
                    backgroundColor: Colors.white,
                    title: 'Breaks short',
                    quantity: state.statistics[1].completedCycles.toString(),
                    minutes: '${state.statistics[1].minutes} min',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ItemStatistic(
                    backgroundColor: Colors.white,
                    title: 'Breaks long',
                    quantity: state.statistics[2].completedCycles.toString(),
                    minutes: '${state.statistics[2].minutes} min',
                  ),
                ],
              ),
            ],
          );
        });
  }
}

class ItemStatistic extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final String quantity;
  final String minutes;

  const ItemStatistic({
    required this.backgroundColor,
    required this.title,
    required this.quantity,
    required this.minutes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: backgroundColor,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(title,
                style: const TextStyle(fontSize: 20, color: Colors.black)),
            const SizedBox(height: 10),
            Text(
              quantity,
              style: const TextStyle(
                fontSize: 35,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(minutes,
                style: const TextStyle(fontSize: 20, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

class DeformedCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.quadraticBezierTo(
        size.width, 0, size.width, size.height / 1.7); // Parte derecha
    path.quadraticBezierTo(size.width, size.height, size.width / 1.7,
        size.height); // Parte inferior
    path.quadraticBezierTo(
        0, size.height, 0, size.height / 1.7); // Parte izquierda
    path.quadraticBezierTo(0, 0, size.width / 1.7, 0); // Parte superior
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
