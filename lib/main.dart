import 'package:flutter/material.dart';
import 'package:vehiclerepair/screens/home_screen.dart';
import 'package:vehiclerepair/screens/log_in_screen.dart';
import 'package:vehiclerepair/servides/auth_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vehicle Repair Booking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FutureBuilder<bool>(
          future: AuthService().isLoggedIn(),
          builder: (context,snapshot){
            if (snapshot.connectionState ==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
    }
            if (snapshot.hasData && snapshot.data == true){
              return HomeScreen();
    }
            return LogInScreen();
    }));
  }
  }



