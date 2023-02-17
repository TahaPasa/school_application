import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MesajlarRepository extends ChangeNotifier{
  final List<Mesaj> mesajlar = [
    Mesaj("How are you?", "Taha Alp", DateTime.now().subtract(Duration(minutes: 5))),
    Mesaj("Great! and you?", "Yusuf", DateTime.now().subtract(Duration(minutes: 3))),
    Mesaj("Yup!", "Taha Alp", DateTime.now()),
    Mesaj("Thanks for asking :)", "Taha Alp", DateTime.now()),
  ];
}

final mesajlarProvider = ChangeNotifierProvider((ref) => MesajlarRepository());

class YeniMesajSayisi extends StateNotifier<int>{
  YeniMesajSayisi(super.state);

  void sifirla(){
    state = 0;
  }
}

final YeniMesajSayisiProvider = StateNotifierProvider<YeniMesajSayisi,int>((ref) => YeniMesajSayisi(4));

class Mesaj {
  String yazi;
  String gonderen;
  DateTime zaman;

  Mesaj(this.yazi, this.gonderen, this.zaman);
}