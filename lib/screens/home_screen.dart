import 'package:flutter/material.dart';
import 'package:vehiclerepair/controllers/app_styles.dart';
import '../model/station_model.dart';
import '../servides/auth_services.dart';
import '../widgets/station_card_widget.dart';
import 'booking_screen.dart';
import 'log_in_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<stationModel> stations = [
    stationModel(
      id: '1',
      name: 'AutoFix Garage',
      distance: 1.2,
      ratings: 4.8,
      type: 'Mechanic',
      imageUrl: 'https://images.unsplash.com/photo-1549399542-7e3f8b79c341',
    ),
    stationModel(
      id: '2',
      name: 'QuickService Center',
      distance: 2.5,
      ratings: 4.6,
      type: 'Mechanic',
      imageUrl: 'https://images.unsplash.com/photo-1486704155675-e4c07f8ad160',
    ),
    stationModel(
      id: '3',
      name: 'SpeedyFix Auto',
      distance: 3.1,
      ratings: 4.5,
      type: 'Mechanic',
      imageUrl: 'https://images.unsplash.com/photo-1630026282177-05317bd77add',
    ),
    stationModel(
      id: '4',
      name: 'AutoCare Express',
      distance: 4.2,
      ratings: 4.4,
      type: 'Mechanic',
      imageUrl: 'https://images.unsplash.com/photo-1487754180451-c456f719a1fc',
    ),
    stationModel(
      id: '5',
      name: 'PowerFuel Station',
      distance: 0.8,
      ratings: 4.7,
      type: 'Fuel Station',
      imageUrl: 'https://images.unsplash.com/photo-1565608438257-fac3c27beb36',
    ),
    stationModel(
      id: '6',
      name: 'GasNGo Stop',
      distance: 1.7,
      ratings: 4.3,
      type: 'Fuel Station',
      imageUrl: 'https://images.unsplash.com/photo-1605039814683-cd9c4a07e5a5',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Repair Booking', style: TextStyle(
            fontSize: 25,
            color: Colors.grey[600],
            fontFamily: "Montserrat",
          fontWeight: FontWeight.bold
        ),),
        actions: [
          IconButton(
            icon: Icon(Icons.logout,color: Colors.red,),
            onPressed: () async {
              await AuthService().logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => LogInScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                width: 400,
                height: 150,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),color: AppStyles.splashColor,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                      child: Text(
                        'Hello, ${AuthService().currentUser?.email.split('@').first ?? 'User'}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                          color: AppStyles.whiteColor
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                      child: Text(
                        'Find repair stations near you',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Montserrat",
                            color: AppStyles.whiteColor
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: stations.length,
                  itemBuilder: (context, index) {
                    return StationCard(
                      station: stations[index],
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BookingScreen(station: stations[index]),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}