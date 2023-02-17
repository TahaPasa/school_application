import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OgretmenlerRepository extends ChangeNotifier{
  final Ogretmenler = [
    Ogretmen("Ankaralı", "Turgut", 37, "Erkek"),
    Ogretmen("Şebnem", "Ferah", 35, "Kadın"),
    Ogretmen("Uğur", "Arslan", 35, "Erkek"),
  ];

}

final ogretmenlerProvider = ChangeNotifierProvider((ref) => OgretmenlerRepository());

class Ogretmen{
  String ad;
  String soyad;
  int yas;
  String cinsiyet;

  Ogretmen(this.ad, this.soyad, this.yas, this.cinsiyet);
}