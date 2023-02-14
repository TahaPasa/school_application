class OgretmenlerRepository{
  final Ogretmenler = [
    Ogretmen("Ankaralı", "Turgut", 37, "Erkek"),
    Ogretmen("Şebnem", "Ferah", 35, "Kadın"),
    Ogretmen("Uğur", "Arslan", 35, "Erkek"),
  ];

}

class Ogretmen{
  String ad;
  String soyad;
  int yas;
  String cinsiyet;

  Ogretmen(this.ad, this.soyad, this.yas, this.cinsiyet);
}