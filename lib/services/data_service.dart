import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_app/models/ogretmen.dart';


class DataService{
  Ogretmen ogretmenDownload() {
    const exampleJson = """{
      "ad" : "Mustafa",
      "soyad" : "Atadan",
      "yas" : 22,
      "cinsiyet" : "Erkek"
    }""";

    final decodedJson = jsonDecode(exampleJson);

    final ogretmen = Ogretmen.fromMap(decodedJson);
    return ogretmen;
  }

}


final dataServiceProvider = Provider((ref) => DataService());

