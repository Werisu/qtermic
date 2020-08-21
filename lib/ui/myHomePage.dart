import 'package:flutter/material.dart';
import 'package:qtermic/screens/screen_city.dart';
import 'package:qtermic/translation/getClima.dart';
import 'package:qtermic/util/util.dart' as util;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _cidadeSet;

  Future _openNewScreen(BuildContext context) async {
    Map result = await Navigator.of(context).push(
      new MaterialPageRoute<Map>(
        builder: (BuildContext context) {
          return new MudarCidade();
        },
      ),
    );

    setState(() {
      if (result != null && result.containsKey('cidade')) {
        _cidadeSet = result['cidade'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QTermic"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _openNewScreen(context),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/umbrella.png",
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    _cidadeSet == null ? util.cidade : _cidadeSet,
                    style: styleCity(),
                  )
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset("assets/light_rain.png"),
          ),
          refrashClimaWidget(_cidadeSet)
        ],
      ),
    );
  }

  Widget refrashClimaWidget(String cidade) {
    return FutureBuilder(
      future: getClima(util.appId, cidade == null ? util.cidade : cidade),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          Map data = snapshot.data;
          return Container(
            margin: const EdgeInsets.fromLTRB(30.0, 250.0, 0.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  title: Text(
                    data['main']['temp'].toString() + "°C",
                    style: tempStyle(),
                  ),
                  subtitle: ListTile(
                    title: Text(
                      "Humidade: ${data['main']['humidity'].toString()}\n"
                      "Min: ${data['main']['temp_min'].toString()}°C\n"
                      "Max: ${data['main']['temp_max'].toString()}°C",
                      style: extraTemp(),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return Container(
            child: Text("Falhou!"),
          );
        }
      },
    );
  }
}

TextStyle extraTemp() {
  return TextStyle(
      color: Colors.white70, fontStyle: FontStyle.normal, fontSize: 17.0);
}

TextStyle styleCity() {
  return TextStyle(
    color: Colors.white70,
    fontStyle: FontStyle.italic,
    fontSize: 22.9,
  );
}

TextStyle tempStyle() {
  return TextStyle(
    color: Colors.white,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontSize: 40.0,
  );
}
