class MesajlarRepository{
  final List<Mesaj> mesajlar = [
    Mesaj("How are you?", "Taha Alp", DateTime.now().subtract(Duration(minutes: 5))),
    Mesaj("Great! and you?", "Yusuf", DateTime.now().subtract(Duration(minutes: 3))),
    Mesaj("Yup!", "Taha Alp", DateTime.now()),
    Mesaj("Thanks for asking :)", "Taha Alp", DateTime.now()),

  ];
  int mesajSayisi =4;
}

class Mesaj {
  String yazi;
  String gonderen;
  DateTime zaman;

  Mesaj(this.yazi, this.gonderen, this.zaman);
}