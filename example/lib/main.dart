import 'package:flutter/material.dart';
import 'package:google_maps_pick_place/google_maps_pick_place.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps Pick Place Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Google Maps Pick Place Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String address = "";
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Address: $address',
            ),
            Text(
              'Latitude: $latitude ',
            ),
            Text(
              'Longitude: $longitude',
            ),
            RaisedButton(
              child: Text('Pick Place'),
              color: Colors.blue,
              elevation: 0.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GoogleMapsPickPlace(
                      apiKey: 'YOUR_GOOGLE_MAPS_API_KEY',
                      getResult: (FullAddress fullAddress) {
                        setState(() {
                          address = fullAddress.address.toString();
                          latitude = fullAddress.position!.latitude;
                          longitude = fullAddress.position!.longitude;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
