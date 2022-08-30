import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locatInfo;
  LocationScreen({this.locatInfo});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temp;
  int min;
  int max;
  int humidity;
  int pressure;
  int windspeed;
  int winddegree;
  String icon;
  String name;
  String msg;
  String description;
  var cityname;
  WeatherModel weatherModel = WeatherModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UpdateUi(widget.locatInfo);
  }

  void UpdateUi(dynamic weatherdata) {
    setState(() {
      if (weatherdata == null) {
        temp = 0;
        icon = '!';
        msg = ',Turn your Location on Please';
        return;
      }
      temp = weatherdata['main']['temp'].toInt();
      icon = weatherModel.getWeatherIcon(weatherdata['weather'][0]['id']);
      name = weatherdata['name'];
      msg = weatherModel.getMessage(temp);
      min = weatherdata['main']['temp_min'].toInt();
      max = weatherdata['main']['temp_max'].toInt();
      humidity = weatherdata['main']['humidity'].toInt();
      pressure = weatherdata['main']['pressure'].toInt();
      description = weatherdata['weather'][0]['description'];
      windspeed = weatherdata['wind']['speed'].toInt();
      winddegree = weatherdata['wind']['deg'].toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Location_Picture.jpg'),
            fit: BoxFit.cover,
            
            colorFilter: ColorFilter.mode(
                Colors.black87.withOpacity(0.10), BlendMode.dstATop),
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
                      var newdata = await weatherModel
                          .GetWeatherDataFromCurrentLocation();
                      UpdateUi(newdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color : Colors.white
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      cityname = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (cityname != null) {
                        var weatherdata =
                            await weatherModel.GetWeatherDataByCityName(
                                cityname);
                        print(weatherdata);
                        UpdateUi(weatherdata);
                      } 
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color : Colors.white
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temp.toString()}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$icon',
                      style: kConditionTextStyle,
                    ),
                   
                  ],
                ),
              ),
              Container(
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      ' $description',
                      style: KDescriptionTextStyle,
                      
                    ),
                    Text(
                      'Min : $min°',
                      style: KDescriptionTextStyle,
                      
                    ),
                    Text(
                      'Max : $max°',
                      style: KDescriptionTextStyle,
                      
                    ),
                    
                     
                     
                  ],
                ),
              ),
                       Container(
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                     Text(
                      'humidity : $humidity %',
                      style: KDescriptionTextStyle,
                      
                    ),
                    Text(
                      'pressure : $pressure hPa',
                      style: KDescriptionTextStyle,
                      
                    ),
                   
                     
                  ],
                ),
              ),
                   Container(
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                     Text(
                      'Wind Speed : $windspeed meter/s',
                      style: KDescriptionTextStyle,
                      
                    ),
                    Text(
                      'Wind Deg : $winddegree ',
                      style: KDescriptionTextStyle,
                      
                    ),
                   
                     
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$msg in $name!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
