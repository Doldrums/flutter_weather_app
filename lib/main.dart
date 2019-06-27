import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';


void _UpdateData(){
  String _temp1 = "-";
  String _wind1 = "-";
  String _max1 = "-";
  String _hum1 = "-";
  http.get('https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22').then((response) {
    Weather _weather;
    _weather = Weather.fromJson(jsonDecode(response.body));
    _temp1 = _weather.temp?.toString();
    _wind1 = _weather.wind?.toString();
    _max1 = _weather.max?.toString();
    _hum1 = _weather.hum?.toString();
    NewWeatherState(_hum1, _max1, _temp1, _wind1).build(NewWeatherState(_hum1, _max1, _temp1, _wind1).context);
  }).catchError((error){
    print("Error: $error");
  });
}

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
  Widget build(BuildContext context) {
    String _temp1 = "-";
    String _wind1 = "-";
    String _max1 = "-";
    String _hum1 = "-";
    Weather _weather;
    http.get('https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22',headers: {'Accept':'application/json'}).then((response) {
      print(response.body);
      _weather = Weather.fromJson(json.decode(response.body));
      _temp1 = _weather.temp?.toString();
      _wind1 = _weather.wind?.toString();
      _max1 = _weather.max?.toString();
      _hum1 = _weather.hum?.toString();
      WeatherInfo(_hum1, '10', _temp1, _wind1);
    }).catchError((error){
      print("!!!!!!!!!Error: $error");
    });

    WeatherInfo(_hum1, '20', _temp1, _wind1);
    return new Column(
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
                    'Weather ',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                  new Icon(
                    Icons.wb_sunny,
                    color: Colors.blueAccent,
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
                    '27 June 2019',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
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
        new Container(
          height: 20,
        ),
        new Center(
            child: new Image.asset('images/clouds.png', width: 150, height: 150,),),
        new WeatherInfo('223', '223', '223', '223'),
        new FloatingActionButton(
          onPressed: _UpdateData,
          child: Icon(Icons.add),
        ),
      ],
    );
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
  final String _temp;
  final String _wind;
  final String _max;
  final String _hum;
  NewWeatherState(this._temp, this._wind, this._max, this._hum);


  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Center(
          child: new Text(
              '$_temp°',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
        ),
        new Center(
          child: new Text(
        'Hello everyone',
        style: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w300,
        color: Colors.indigo),
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
                  color: Colors.grey),
            )), flex: 3,),
            new Expanded(child: new Center( child : Text(
              'Humidity',
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            )), flex: 2,),
            new Expanded(child: new  Center( child: Text(
              'Maximum',
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            )), flex: 3,),
            new Expanded(child: new Text(
              '',
            ), flex: 1,),
          ],
        )
      ],
    );
  }

}

void main() {
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(body: new Main())));
}
