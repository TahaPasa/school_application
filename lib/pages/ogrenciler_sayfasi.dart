import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app/repository/ogrenciler_repository.dart';

class OgrencilerSayfasi extends StatefulWidget {
  final OgrencilerRepository ogrencilerRepository;
  const OgrencilerSayfasi(this.ogrencilerRepository, {Key? key}) : super(key: key);

  @override
  State<OgrencilerSayfasi> createState() => _OgrencilerSayfasiState();
}

class _OgrencilerSayfasiState extends State<OgrencilerSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Öğrenciler Sayfası")),
      body: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
                child: Text("${widget.ogrencilerRepository.Ogrenciler.length} Öğrenci"),
              ),
            ),
          ),
          Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => OgrenciSatiri(
                  widget.ogrencilerRepository.Ogrenciler[index],
                    widget.ogrencilerRepository,
                ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: widget.ogrencilerRepository.Ogrenciler.length,
              )
          ),
        ],
      ),
    );
  }
}

class OgrenciSatiri extends StatefulWidget {
  final Ogrenci ogrenciler;
  final OgrencilerRepository ogrencilerRepository;
  const OgrenciSatiri(this.ogrenciler, this.ogrencilerRepository, {
    Key? key,
  }) : super(key: key);

  @override
  State<OgrenciSatiri> createState() => _OgrenciSatiriState();
}

class _OgrenciSatiriState extends State<OgrenciSatiri> {
  @override
  Widget build(BuildContext context) {
    bool seviyorMuyum = widget.ogrencilerRepository.seviyorMuyum(widget.ogrenciler);

    return ListTile(
      leading: IntrinsicWidth(child: Center(child: Text(widget.ogrenciler.cinsiyet == "Erkek" ? "🧔🏻‍♂": "️👩🏼"))),
      trailing: IconButton(
        onPressed: () {
          setState(() {
            widget.ogrencilerRepository.sev(widget.ogrenciler, !seviyorMuyum);
          });


        },
        icon: Icon(seviyorMuyum ?  Icons.favorite: Icons.favorite_border),
      ),
      title: Text(widget.ogrenciler.ad + " " + widget.ogrenciler.soyad),
    );
  }
}
