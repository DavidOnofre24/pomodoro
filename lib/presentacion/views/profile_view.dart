import 'package:flutter/material.dart';
import 'package:pomodoro/config/constants/colors.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Profile',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            ClipPath(
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
            ),
            const SizedBox(height: 20),
            const Text('jackson@gmail.com', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: CustomColors.pink,
                    ),
                    padding: const EdgeInsets.all(20),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Today focus',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                        SizedBox(height: 10),
                        Text(
                          '16',
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('320 min',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(20),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Today focus',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                        SizedBox(height: 10),
                        Text(
                          '16',
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('320 min',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Today focus',
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  SizedBox(height: 10),
                  Text(
                    '16',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('320 min',
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                ],
              ),
            ),
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
