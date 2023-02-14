import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app/repository/ogretmenler_repository.dart';

class OgretmenlerSayfasi extends StatefulWidget {
  final OgretmenlerRepository ogretmenlerRepository;
  const OgretmenlerSayfasi(this.ogretmenlerRepository, {Key? key}) : super(key: key);

  @override
  State<OgretmenlerSayfasi> createState() => _OgretmenlerSayfasiState();
}

class _OgretmenlerSayfasiState extends State<OgretmenlerSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Öğretmenler Sayfası")),
      body: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
                child: Text("${widget.ogretmenlerRepository.Ogretmenler.length} Öğretmen"),
              ),
            ),
          ),
          Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => OgretmenSatiri(
                  widget.ogretmenlerRepository.Ogretmenler[index],
                  widget.ogretmenlerRepository,
                ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: widget.ogretmenlerRepository.Ogretmenler.length,
              )
          ),
        ],
      ),
    );
  }
}



class OgretmenSatiri extends StatefulWidget {
  final Ogretmen ogretmenler;
  final OgretmenlerRepository ogretmenlerRepository;
  const OgretmenSatiri(this.ogretmenler, this.ogretmenlerRepository, {
    Key? key,
  }) : super(key: key);

  @override
  State<OgretmenSatiri> createState() => _OgretmenSatiriState();
}

class _OgretmenSatiriState extends State<OgretmenSatiri> {
  @override
  Widget build(BuildContext context) {


    return ListTile(
      leading: IntrinsicWidth(child: Center(child: Text(widget.ogretmenler.cinsiyet == "Erkek" ? "🧔🏻‍♂": "️👩🏼"))),
      title: Text(widget.ogretmenler.ad + " " + widget.ogretmenler.soyad),
    );
  }
}
