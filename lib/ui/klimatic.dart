import 'package:flutter/material.dart';

class Klimatic extends StatefulWidget {
  @override
  _KlimaticState createState() => new _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Weather live"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.menu),
            onPressed:()=> debugPrint( "hey"),
          )
        ],


      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset('images/rain.jpg',
            width: 470.0,
            height: 1200.0,
            fit: BoxFit.fill,),
          ),
          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
            child: new Text(
              "Spokane",
              style:  cityStyle(),
            ),
          )
        ],
      ),
    );
  }
}
 TextStyle cityStyle(){
  return new TextStyle(
    fontSize: 22.9,
    color: Colors.white,
    fontStyle: FontStyle.italic,
  );
 }
