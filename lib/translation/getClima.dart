import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map> getClima(String appId, String cidade) async {
  // String apiUrl =
  //     "https://api.openweathermap.org/data/2.5/weather?q=$cidade&appid=$appId=metric";
  String url =
      "https://api.openweathermap.org/data/2.5/weather?q=$cidade&appid=$appId&units=metric";

  http.Response response = await http.get(url);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception("Error: ${response.statusCode}");
  }
}
