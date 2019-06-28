import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';


class Weather {
  final String temp;
  final String wind;
  final String max;
  final String hum;

  Weather({this.hum, this.max, this.temp, this.wind});

  factory Weather.fromJson(Map<String, dynamic> json) {
    print(json["main"]["temp"]);
    print(json["main"]["temp"]);
    print(json["main"]["temp_max"]);
    print(json["main"]["humidity"]);
    return Weather(
        temp: json["main"]["temp"].toString(),
        wind: json["main"]["temp"].toString(),
        max: json["main"]["temp_max"].toString(),
        hum: json["main"]["humidity"].toString()
    );
  }
}
class Main extends StatelessWidget {
  var date = new DateTime.now();
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.white,
        child: Column(
      children: [
        new Container(
          height: 50,
        ),
        new Row(
          children: <Widget>[
            new Expanded(
              child: Text(''),
              flex: 7,
            ),
            new Expanded(
              child: Row(
                children: <Widget>[
                  new Text(
                    '          Weather  ',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                  new Icon(
                    Icons.wb_sunny,
                    color: Colors.black,
                    size: 15.0,
                  ),
                ],
              ),
              flex: 3,
            )
          ],
        ),
        new Row(
          children: <Widget>[
            new Expanded(
                child: Row(
              children: <Widget>[
                new Expanded(
                  child: new Text(
                    '   Kaliningrad',
                    style: TextStyle(
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  flex: 5,
                ),
                new Expanded(
                  child: new Text(''),
                  flex: 4,
                )
              ],
            ))
          ],
        ),
        new Row(
          children: <Widget>[
            new Expanded(
                child: Row(
              children: <Widget>[
                new Expanded(
                  child: new Text(''),
                  flex: 1,
                ),
                new Expanded(
                  child: new Text(
                    date.toString(),
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black38),
                  ),
                  flex: 4,
                ),
                new Expanded(
                  child: new Text(''),
                  flex: 5,
                )
              ],
            ))
          ],
        ),
        new Center(
            child: new Image.asset('images/sea.gif', width: 500, height: 300,),),
        new WeatherInfo('None', 'None', 'None', 'None'),
      ],
    ));
  }
}

class WeatherInfo extends StatefulWidget {
  final String _temp;
  final String _wind;
  final String _max;
  final String _hum;

  WeatherInfo(this._hum, this._max, this._temp, this._wind);
  @override
  createState() => new NewWeatherState(_temp,_wind, _max, _hum);


}

class NewWeatherState extends State<WeatherInfo> {
   String _temp;
   String _wind;
   String _max;
   String _hum;
  NewWeatherState(this._temp, this._wind, this._max, this._hum);

  void pressBtn(){
    setState(() {
      http.get('https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22').then((response) {
        Weather _weather;
        _weather = Weather.fromJson(jsonDecode(response.body));
        _temp = _weather.temp?.toString();
        _wind = _weather.wind?.toString();
        _max = _weather.max?.toString();
        _hum = _weather.hum?.toString();
        NewWeatherState(this._temp, this._wind, this._max, this._hum);
      }).catchError((error){
        print("Error: $error");
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Center(
          child: new Text(
              '$_temp°',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
        ),
        new Center(
          child: new Text(
        'Hello everyone!',
        style: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w300,
        color: Colors.black38),
                    ),
        ),
        new Container(height: 20,),
        new Row(
        children: <Widget>[
          new Expanded(child: new Text(
            '',
          ), flex: 1,),
          new Expanded(child: new Center( child : Text(
              '$_wind',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
          )), flex: 3,),
          new Expanded(child: new Center( child : Text(
          '$_hum',
          style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w400,
          color: Colors.black),
          )), flex: 2,),
          new Expanded(child: new  Center( child: Text(
            '$_max',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Colors.black),
          )), flex: 3,),
          new Expanded(child: new Text(
            '',
          ), flex: 1,),
    ],
    ),
        new Row(
          children: <Widget>[
            new Expanded(child: new Text(
              '',
            ), flex: 1,),
            new Expanded(child: new Center( child : Text(
              'Wind',
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black38),
            )), flex: 3,),
            new Expanded(child: new Center( child : Text(
              'Humidity',
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black38),
            )), flex: 2,),
            new Expanded(child: new  Center( child: Text(
              'Maximum',
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black38),
            )), flex: 3,),
            new Expanded(child: new Text(
              '',
            ), flex: 1,),

          ],
        ),
        new RaisedButton(
          onPressed: pressBtn,
          child: new Text('UPDATE DATA', style: TextStyle(color: Colors.white),),
          color: Colors.deepOrange,
        ),
      ],
    );
  }

}

void main() {
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(body: new Main())));
}
