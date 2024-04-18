import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/config/constants/colors.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigation({super.key, required this.currentIndex});

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/0');
        break;

      case 1:
        context.go('/home/1');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) => onItemTapped(context, value),
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.access_time),
                label: 'Pomodoro',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ]),
        Positioned(
          left: MediaQuery.of(context).size.width / 2 * currentIndex +
              MediaQuery.of(context).size.width / 6 -
              16,
          bottom: 0,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: CustomColors.pink,
            ),
            width: 100,
            height: 4,
          ),
        ),
      ],
    );
  }
}
