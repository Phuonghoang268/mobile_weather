import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

void main() => runApp(MaterialApp(
      title: "Weather App",
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
    throw UnimplementedError();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=Hanoi,vn&units=metric&lang=vi&APPID=7179bc1bbc4e13b28740d0ccf3dafb28"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.grey.shade500,
            Colors.black,
          ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Text(
                  "Thời tiết Hà Nội",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                temp != null ? temp.toString() + "\u00B0"+" C" : "Loading",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  currently != null ? currently.toString() : "Loading",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                title: Text("Nhiệt độ"),
                trailing: Text(temp != null ? temp.toString() + "\u00B0" +" C" : "Loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.cloud),
                title: Text("Thời tiết hôm nay"),
                trailing: Text(description != null ? description.toString() : "Loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.sun),
                title: Text("Độ ẩm"),
                trailing: Text(humidity != null ? humidity.toString(): "Loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.wind),
                title: Text("Mức gió"),
                trailing: Text(windSpeed != null ? windSpeed.toString(): "Loading"),
              )
            ],
          ),
        ))
      ],
    ));
    throw UnimplementedError();
  }
}
