import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import '../util/utils.dart' as util;
import 'package:http/http.dart' as http;

class Klimatic extends StatefulWidget {
  @override
  _KlimaticState createState() => new _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {

  String _cityEntered;
  Future _goToNextScreen(BuildContext context) async {
    Map results = await Navigator.of(context)
        .push(new MaterialPageRoute<Map>(builder: (BuildContext context) {
      return new ChangeCity();
    }));
    if(results!= null && results.containsKey('enter')){
      _cityEntered = results['enter'];
    };
  }

  void showStuff() async {
    Map data = await getWeather(util.appID, util.defaultCity);
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new AppBar(
        title: new Text("Tempy"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.menu),
            onPressed: () {
              _goToNextScreen(context);
            },
          )
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
              'images/rain.jpg',
              width: 470.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),
          ),
          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
            child: new Text(
              "${_cityEntered== null ? util.defaultCity : _cityEntered}",
              style: cityStyle(),
            ),
          ),
          updateTempWidget(_cityEntered),

        ],
      ),
    );
  }

  Future<Map> getWeather(String appID, String city) async {
    var apiUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=${util.appID}&units=metric";
    http.Response response = await http.get(apiUrl);
    return json.decode(response.body);
  }

  Widget updateTempWidget(String city) {
    return new FutureBuilder(
        future: getWeather(util.appID, city == null ? util.defaultCity : city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {

            Map content = snapshot.data;
            return new Container(
              margin: const EdgeInsets.fromLTRB(30.0, 310.0, 0.0, 0.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new ListTile(
                    title: new Text(
                      content['main']['temp'].toString() + " C",
                      style: new TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 49.9,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    subtitle: new ListTile(
                      title: new Text(
                        "Humidity: ${content['main']['humidity'].toString()}\n"
                        "Min: ${content['main']['temp_min'].toString()}\n"
                        "Max: ${content['main']['temp_max'].toString()}",
                        style: new TextStyle(
                          fontSize: 17.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.white70

                        ),
                      ),
                    ),
                  ),

                ],
              ),
            );
          } else {
            return new Container();
          }
        });
  }
}

class ChangeCity extends StatelessWidget {
  var _cityFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Enter a city"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
              child: new Image.asset(
            'images/snow.jpg',
            width: 490.0,
            height: 1200.0,
            fit: BoxFit.fill,
          )),
          new ListView(
            children: <Widget>[
              new ListTile(
                title: new TextField(
                  style: new TextStyle(
                    color: Colors.black,

                  ),
                  decoration: new InputDecoration(
                    fillColor: Colors.white,
                    filled: true,

                    hintText: "Enter City",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    )

                  ),
                  controller: _cityFieldController,
                  keyboardType: TextInputType.text,
                ),
              ),
              new ListTile(
                title : new FlatButton(
                  onPressed: () {
                    Navigator.pop(context,{
                      'enter' : _cityFieldController.text
                    });
                  },
    
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  child: new Text("Get Weather"),
                )
              )
            ],
          )
        ],

      ),
    );
  }
}

TextStyle cityStyle() {
  return new TextStyle(
    fontSize: 22.9,
    color: Colors.white,
    fontStyle: FontStyle.italic,
  );
}

TextStyle tempStyle() {
  return new TextStyle(
    color: Colors.white,
    fontStyle: FontStyle.normal,
    fontSize: 49.9,
  );
}
