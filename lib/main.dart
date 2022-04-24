import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/todo_bloc.dart';
import 'package:todo_list/screens/home_screen.dart';
import 'package:todo_list/screens/todo_list_screen.dart';
import 'package:todo_list/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool welcome = false;

  @override
  void initState() {
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      welcome = prefs.getBool('welcome') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (context) => TodoBloc(),
      child: MaterialApp(
        title: 'TodoList',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => welcome ? HomeScreen() : WelcomeScreen(),
          '/todoList': (context) => TodoListScreen(),
        },
      ),
    );
  }
}
