import 'package:flutter/material.dart';
import 'package:redentuapp/screens/newslist_screen.dart';
import 'package:redentuapp/screens/profile_edit_screen.dart';
import 'screens/newslist_screen.dart';
import 'screens/article_screen.dart';
import 'screens/qr_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/camera_screen.dart';
import 'screens/registration_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: NewsListScreen.id,
      routes: {
        NewsListScreen.id: (context) => NewsListScreen(),
        ProfileEditScreen.id: (context) => ProfileEditScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        QrScreen.id: (context) => QrScreen(),
        CameraScreen.id: (context) => CameraScreen(),
      },
    );
  }
}
