import 'package:flutter/material.dart';

class MudarCidade extends StatelessWidget {
  var _cityControl = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Mudar Cidade"),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/white_snow.png",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            children: <Widget>[
              ListTile(
                title: TextField(
                  decoration: InputDecoration(hintText: "Cidade"),
                  controller: _cityControl,
                  keyboardType: TextInputType.text,
                  autocorrect: true,
                  textCapitalization: TextCapitalization.words,
                ),
              ),
              ListTile(
                title: FlatButton(
                  onPressed: () {
                    Navigator.pop(context, {'cidade': _cityControl.text});
                  },
                  textColor: Colors.white,
                  color: Colors.redAccent,
                  child: Text("Mostra tempo"),
                ),
              )
            ],
          )
        ],
      ),
    );
    throw UnimplementedError();
  }
}
