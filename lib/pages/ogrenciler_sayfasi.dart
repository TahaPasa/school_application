import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_app/repository/ogrenciler_repository.dart';

class OgrencilerSayfasi extends ConsumerWidget {

  const OgrencilerSayfasi({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ogrencilerRepository = ref.watch(ogrencilerProvider);
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
                child: Text("${ogrencilerRepository.Ogrenciler.length} Öğrenci"),
              ),
            ),
          ),
          Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => OgrenciSatiri(
                  ogrencilerRepository.Ogrenciler[index],
                ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: ogrencilerRepository.Ogrenciler.length,
              )
          ),
        ],
      ),
    );
  }
}

class OgrenciSatiri extends ConsumerWidget {
  final Ogrenci ogrenciler;

  const OgrenciSatiri(this.ogrenciler, {
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var ogrencilerRepository = ref.watch(ogrencilerProvider);
    bool seviyorMuyum = ogrencilerRepository.seviyorMuyum(ogrenciler);

    return ListTile(
      leading: IntrinsicWidth(child: Center(child: Text(ogrenciler.cinsiyet == "Erkek" ? "🧔🏻‍♂": "️👩🏼"))),
      trailing: IconButton(
        onPressed: () {
          ref.read(ogrencilerProvider).sev(ogrenciler, !seviyorMuyum);
        },
        icon: Icon(seviyorMuyum ?  Icons.favorite: Icons.favorite_border),
      ),
      title: Text(ogrenciler.ad + " " + ogrenciler.soyad),
    );
  }
}
