import 'package:flutter/material.dart';
import 'package:pomodoro/presentacion/views/home_view.dart';
import 'package:pomodoro/presentacion/views/profile_view.dart';
import 'package:pomodoro/presentacion/widgets/bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: const [
          HomeView(),
          ProfileView(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex),
    );
  }
}
