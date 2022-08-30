import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

const apikey = '0b438b0386c8a8c55f371efd0281bf02';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double long;
  double lat;

  void getLocationData() async {
   WeatherModel weatherModel = WeatherModel();
   var weatherdata = await  weatherModel.GetWeatherDataFromCurrentLocation();
   Navigator.push(context, MaterialPageRoute(builder: (context){
//LocationScreen loc = LocationScreen(temp: weatherdata['main']['temp'],con: weatherdata['weather']['0']['id'],cityname: weatherdata['name']);
     return LocationScreen(locatInfo: weatherdata);
   }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCube(
          size: 150.0,
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.green : Colors.white,
        
      ),
    );
  },
),
      ),
    );
  }
}
