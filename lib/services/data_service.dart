import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_app/models/ogretmen.dart';
import 'package:http/http.dart' as http;

class DataService{
  final String baseUrl = "https://63fb6cc12027a45d8d665335.mockapi.io/";
  Future<Ogretmen> ogretmenDownload() async {
    http.Response response = await http.get(Uri.parse("$baseUrl/teachers/1"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Ogretmen.fromMap(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Öğretmen indirilemedi ${response.statusCode}');
    }

    // const exampleJson = """{
    //   "ad" : "Mustafa",
    //   "soyad" : "Atadan",
    //   "yas" : 22,
    //   "cinsiyet" : "Erkek"
    // }""";
    //
    // final decodedJson = jsonDecode(exampleJson);
    //
    // final ogretmen = Ogretmen.fromMap(decodedJson);
    // return ogretmen;
  }

    Future<void> ogretmenEkle(Ogretmen ogretmen) async {

    final response = await http.post(
      Uri.parse("$baseUrl/teachers/1"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(ogretmen.toMap()),
    );

    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Öğretmen yüklenemedi ${response.statusCode}');
    }
  }

  Future<List<Ogretmen>> ogretmenleriGetir() async {
    final response = await http.get(Uri.parse("$baseUrl/teachers"));

    if (response.statusCode == 200) {
      final l = jsonDecode(response.body);
      return l.map<Ogretmen>((e) => Ogretmen.fromMap(e)).toList();

    } else {

      throw Exception('Öğretmen indirilemedi ${response.statusCode}');
    }

  }


}


final dataServiceProvider = Provider((ref) => DataService());

