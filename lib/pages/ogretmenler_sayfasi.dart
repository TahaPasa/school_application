import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_app/repository/ogretmenler_repository.dart';

import '../models/ogretmen.dart';
import 'ogretmen/ogretmen_form.dart';

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
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
                    child: Text("${ogretmenlerRepository.ogretmenler.length} Öğretmen"),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: OgretmenindirmeButonu(),
                )
              ],
            ),
          ),
          Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  ref.refresh(ogretmenlerListesiProvider);
                },
                child: ref.watch(ogretmenlerListesiProvider).when(
                    data: (data) => ListView.separated(
                      itemBuilder: (context, index) => OgretmenSatiri(
                        data[index],
                      ),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: data.length,
                    ),
                    error: (error, stackTrace) {
                      return SingleChildScrollView(
                          child: Text("Hata"),
                          physics: AlwaysScrollableScrollPhysics(),
                      );
                    },
                    loading: () {
                      return Center(child: CircularProgressIndicator(),);
                    },
                ),
              )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await Navigator.of(context).push<bool>(MaterialPageRoute(builder: (context) => OgretmenForm(),));
          if(created == true){
            // print("öğretmenleri yenile!");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Öğretmen Eklendi!")),
            );
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class OgretmenindirmeButonu extends StatefulWidget {
  const OgretmenindirmeButonu({
    Key? key,
  }) : super(key: key);

  @override
  State<OgretmenindirmeButonu> createState() => _OgretmenindirmeButonuState();
}

class _OgretmenindirmeButonuState extends State<OgretmenindirmeButonu> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return isLoading ? CircularProgressIndicator(): IconButton(
          icon: const Icon(Icons.download),
          onPressed: () async {
            //TODO Loading
            //TODO error
            try{

            setState((){
              isLoading = true;
            });
            await ref.read(ogretmenlerProvider).download();
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
              );
            }
            finally{
            setState((){
              isLoading = false;
            });
            }
          },
        );
      }
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
