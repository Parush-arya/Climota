import 'package:climota/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:climota/utilities/constants.dart';
import 'package:climota/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherData});
  var weatherData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    int temp = (widget.weatherData['main']['temp']).toInt();
    int condition = widget.weatherData['weather'][0]['id'];
    String cityname = widget.weatherData['name'];
    WeatherModel weatherModel = WeatherModel();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      WeatherModel weatherModel = WeatherModel();
                      widget.weatherData = await weatherModel.getWeatherData();
                      setState(() {
                        widget.weatherData = widget.weatherData;
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 40.0,
                    ),
                  ),
                  Text(
                    'Climota',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontFamily: 'pacifico',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));

                      if (typedName != null) {
                        var Data = await weatherModel.getCityWeather(typedName);

                        if (Data['cod'] != '404' && Data != -1)
                          widget.weatherData = Data;
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "City Name Thikse Daal be nalayak!",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            duration: Duration(seconds: 4),
                          ));
                        }
                      }
                      setState(() {
                        widget.weatherData = widget.weatherData;
                      });
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(220, 220, 220, 0.2),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "$temp" + '°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        '${weatherModel.getWeatherIcon(condition)}',
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 60, left: 15.0, right: 15.0),
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(220, 220, 220, 0.2),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  "${weatherModel.getMessage(temp)} in $cityname!",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle.copyWith(
                    fontSize: 45,
                    fontFamily: 'Gaegu',
                    letterSpacing: -4,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
