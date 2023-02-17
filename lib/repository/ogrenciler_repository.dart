import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OgrencilerRepository extends ChangeNotifier{
  final Ogrenciler = [
    Ogrenci("Taha Alp", "Koçyiğit", 20, "Erkek"),
    Ogrenci("Yusuf", "Boraslan", 20, "Erkek"),
    Ogrenci("Lin", "Pesto", 35, "Kadın"),
  ];

  final Set<Ogrenci> sevdiklerim = {};

  void sev(Ogrenci ogrenciler, bool seviyorMuyum) {
    if(seviyorMuyum)
      {
        sevdiklerim.add(ogrenciler);
      }
    else
      {
        sevdiklerim.remove(ogrenciler);
      }
    notifyListeners();
  }

  bool seviyorMuyum(Ogrenci ogrenciler) {
    return sevdiklerim.contains(ogrenciler);
  }

}

final ogrencilerProvider = ChangeNotifierProvider((ref) => OgrencilerRepository());

class Ogrenci{
  String ad;
  String soyad;
  int yas;
  String cinsiyet;

  Ogrenci(this.ad, this.soyad, this.yas, this.cinsiyet);
}