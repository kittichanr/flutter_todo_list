import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/screens/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        margin: const EdgeInsets.only(top: 200),
        child: Column(
          children: [
            Image.asset('assets/images/to-do-list.png',
                height: 280, width: 200),
            const SizedBox(height: 40),
            const Text(
              'Get Organized Your Life',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Todo is a simple and effective\nto-do list and task manager app\nwhich helps you manage time.',
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.5,
                color: Colors.black54,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 40),
            Container(
              height: 55.0,
              margin: const EdgeInsets.symmetric(horizontal: 32),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                      colors: [Colors.greenAccent, Colors.green])),
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('welcome', true);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreen()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Get Started'),
              ),
            )
          ],
        ),
      )),
    );
  }
}
