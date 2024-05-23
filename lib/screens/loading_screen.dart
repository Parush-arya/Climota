import 'package:flutter/material.dart';
import 'package:climota/services/weather.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    process();
  }

  void process() async {
    await Future.delayed(Duration(seconds: 2));
    getLocData();
  }

  void getLocData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getWeatherData();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationScreen(
                  weatherData: weatherData,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Climota!',
              style: TextStyle(fontSize: 50),
            ),
            Text(
              'Your weather assistant.',
              style: TextStyle(fontSize: 25, color: Colors.white70),
            ),
            SizedBox(
              width: 200,
              child: Divider(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SpinKitDoubleBounce(
              color: Colors.white,
              size: 200,
            ),
          ]),
    );
  }
}
