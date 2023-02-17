import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_app/repository/ogretmenler_repository.dart';

class OgretmenlerSayfasi extends ConsumerWidget {

  const OgretmenlerSayfasi({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final ogretmenlerRepository = ref.watch(ogretmenlerProvider);
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
                child: Text("${ogretmenlerRepository.Ogretmenler.length} Öğretmen"),
              ),
            ),
          ),
          Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => OgretmenSatiri(
                  ogretmenlerRepository.Ogretmenler[index],
                ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: ogretmenlerRepository.Ogretmenler.length,
              )
          ),
        ],
      ),
    );
  }
}



class OgretmenSatiri extends StatelessWidget {
  final Ogretmen ogretmenler;
  const OgretmenSatiri(this.ogretmenler,{
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {


    return ListTile(
      leading: IntrinsicWidth(child: Center(child: Text(ogretmenler.cinsiyet == "Erkek" ? "🧔🏻‍♂": "️👩🏼"))),
      title: Text(ogretmenler.ad + " " + ogretmenler.soyad),
    );
  }
}
