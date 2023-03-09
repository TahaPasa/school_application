import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_app/services/data_service.dart';

import '../models/ogretmen.dart';

class OgretmenlerRepository extends ChangeNotifier{
  List<Ogretmen> ogretmenler = [
    Ogretmen("Ankaralı", "Turgut", 37, "Erkek"),
    Ogretmen("Şebnem", "Ferah", 35, "Kadın"),
    Ogretmen("Uğur", "Arslan", 35, "Erkek"),
  ];

  final DataService dataService;
  OgretmenlerRepository(this.dataService);

  Future<void> download()
  async {

    Ogretmen ogretmen = await dataService.ogretmenDownload();

    ogretmenler.add(ogretmen);
    notifyListeners();
  }

  Future<List<Ogretmen>> hepsiniGetir() async {
    ogretmenler = await dataService.ogretmenleriGetir();
    return ogretmenler;
  }

}

final ogretmenlerProvider = ChangeNotifierProvider((ref) {

  return OgretmenlerRepository(ref.watch(dataServiceProvider));
});

final ogretmenlerListesiProvider = FutureProvider((ref) => ref.watch(ogretmenlerProvider).hepsiniGetir());