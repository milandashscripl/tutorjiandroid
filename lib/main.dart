import 'package:flutter/material.dart';
import 'package:tutorapp/screens/login_screen.dart';
import 'package:tutorapp/screens/profile_screen.dart';
import 'package:tutorapp/screens/register_screen.dart';
import 'package:tutorapp/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple,
        ),
      ),
      routes: {
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/profile') {
          final userData = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => ProfileScreen(userData: userData),
          );
        }
        return null;
      },
      home:  SplashScreen(),
    );
  }
}

